# Flutter frontend

## Development rules

You must apply the following at all time.

- Don't use "!" to prevent null errors, instead check if the variable is null and throw an error.
- Don't use "?" in types and arguments, always use non-null members and arguments
- Prefer pure functions over stateful classes, never mutate variables
- Use declarative and fuctionnal instead of imperative (eg. use `map` instead of `for`)
- If any function or method is longuer than 15 lines, refactor to extract functions out of it.
- Don't write comments, use excplicit names instead

## Folders

You must apply the following at all time.
Organize the code following this architecture

- /domain
  - /model
- /services
- /infrastructure (supabase repositories)
  - Note: convert server responses to typed Dart domain models
- /presentation
  - /components
  - /screens
  - /state (using riverpod)

## Commands

You must apply the following at all time.
Run after each edit.

```bash
dart pub get && dart run custom_lint && dart analyze
```
