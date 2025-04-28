-- rooms
CREATE TABLE public.rooms(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp NOT NULL DEFAULT NOW(),
    lang text DEFAULT 'en' ::text,
    status text DEFAULT 'lobby' ::text,
    next_vote integer DEFAULT 0,
    next_room_id uuid REFERENCES public.rooms ON DELETE SET NULL
);

ALTER publication supabase_realtime
    ADD TABLE public.rooms;

-- user profiles
CREATE TABLE public.user_profiles(
    id uuid PRIMARY KEY NOT NULL REFERENCES auth.users ON DELETE CASCADE,
    created_at timestamp NOT NULL DEFAULT NOW(),
    room_id uuid REFERENCES public.rooms ON DELETE SET NULL,
    name text
);

ALTER publication supabase_realtime
    ADD TABLE public.user_profiles;

CREATE INDEX idx_user_profiles_room_id ON public.user_profiles(room_id);

-- room logs
CREATE TABLE public.logs(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp NOT NULL DEFAULT NOW(),
    room_id uuid NOT NULL REFERENCES public.rooms ON DELETE CASCADE,
    content text
);

CREATE INDEX idx_logs_room_id ON public.logs(room_id);

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
    INSERT INTO public.user_profiles(id, name, room_id)
        VALUES(NEW.id, COALESCE(NEW.raw_user_meta_data ->> 'name', NULL), COALESCE(NEW.raw_user_meta_data ->> 'room_id', NULL)::uuid);
    RETURN new;
END;
$$;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE PROCEDURE public.handle_new_user();

