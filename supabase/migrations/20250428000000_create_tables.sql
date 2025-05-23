-- keep-alive
CREATE TABLE "keep-alive" (
  id BIGINT generated BY DEFAULT AS IDENTITY,
  name text NULL DEFAULT '':: text,
  random uuid NULL DEFAULT gen_random_uuid (),
  CONSTRAINT "keep-alive_pkey" PRIMARY key (id)
);

-- games
CREATE TABLE public.games(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp NOT NULL DEFAULT NOW(),
    status text DEFAULT 'lobby' ::text,
    next_game_id uuid REFERENCES public.games ON DELETE SET NULL
);

ALTER publication supabase_realtime
    ADD TABLE public.games;

-- user profiles
CREATE TABLE public.profiles(
    id uuid PRIMARY KEY NOT NULL REFERENCES auth.users ON DELETE CASCADE,
    created_at timestamp NOT NULL DEFAULT NOW(),
    game_id uuid REFERENCES public.games ON DELETE SET NULL,
    name text
);

ALTER publication supabase_realtime
    ADD TABLE public.profiles;

CREATE INDEX idx_profiles_game_id ON public.profiles(game_id);


-- game logs
CREATE TABLE public.logs(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp NOT NULL DEFAULT NOW(),
    game_id uuid NOT NULL REFERENCES public.games ON DELETE CASCADE,
    content text
);

CREATE INDEX idx_logs_game_id ON public.logs(game_id);

ALTER publication supabase_realtime
    ADD TABLE public.logs;

-- create a public profile when a user is created, using the same id
CREATE FUNCTION public.handle_new_user()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = ''
    AS $$
BEGIN
    INSERT INTO public.profiles(id, name, game_id)
        VALUES(NEW.id, COALESCE(NEW.raw_user_meta_data ->> 'name', NULL), COALESCE(NEW.raw_user_meta_data ->> 'game_id', NULL)::uuid);
    RETURN new;
END;
$$;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE PROCEDURE public.handle_new_user();

