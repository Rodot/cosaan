# Flutter frontend

## Folders

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

Run after each edit

```bash
dart pub get && dart run custom_lint && dart analyze
```
