# Flutter frontend

## Development rules

You must apply the following rules at all time.

- Always use non-nullable members and arguments instead of using "?" in types and arguments.
- Use pure functions instead of stateful classes, never mutate variables.
- Use declarative and fuctionnal instead of imperative (eg. use `map` instead of `for`)
- When a method is longuer than 15 lines, refactor to extract functions.
- User explicit function and variable names, never write comments.
- Throw errors from the Domain, services, infrastructure layer premptively.
- Check if the variable is null and throw an error instead of using "!".
- Handle all the errors in the presentation layer by calling showErrorSnackbar.
- Instead of using inline lambda functions, extract functions with a meaninful name.

## Folders

You must apply the following rule at all time:

Organize the using this architecture

- /domain
- /services
- /infrastructure (supabase repositories)
- /presentation
  - /components
  - /screens
  - /utils
  - /state (using riverpod)

## Commands

You must run `./run_quality.sh` after each modification.

If it fails, find the issue, fix it, and run `./run_quality.sh` again.
