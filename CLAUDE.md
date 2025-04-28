# Dev Guidelines

## Tech stack

- Frontend: Flutter
- Backend: Supabase

## Software architecture

- All the game and model state is in the DB as the single source of truth
- All the game logic and models on the backend
- Use MVVM: Front is a view of the model updated in real time
- Use Commands: Game state only mutates through the use of commands
- Frontend never mutate the DB, but sends commands to the backend instead
- Use state machines for game phases, voting, etc.

## Best practices

- Use Domain driven design
- Use functional programming
- Prefer pure functions over stateful classes
- Never mutate variables
- Use declarative instead of imperative (eg. use `map` instead of `for`)
