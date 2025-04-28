# Dev Guidelines

## Tech stack

- /app flutter frontend
- /supabase supabase bakcend

## Software architecture

- All the game and model state is in the DB as the single source of truth
- All the game logic and models on the backend
- Frontend never mutate the DB, but sends commands to the backend instead
- Use state machines for game phases, voting, etc.

## General guidelines

- Use Domain driven design
- Use functional programming
- Prefer pure functions over stateful classes
- Never mutate variables
- Use declarative instead of imperative (eg. use `map` instead of `for`)
- If any function or method is longuer than 15 lines, refactor to extract functions out of it
