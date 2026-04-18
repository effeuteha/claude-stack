# Code Style

- Use the project's existing patterns, not your preferred patterns
- Match indentation, naming conventions, and file organization of surrounding code
- Don't add docstrings, comments, or type annotations to code you didn't change
- Only add comments where the logic isn't self-evident
- Don't refactor code adjacent to your changes unless asked

## Naming

```python
# Follow existing conventions — if the codebase uses snake_case, use snake_case
def get_user_by_id(user_id: int):     # CORRECT (matches existing)
def getUserById(userId: int):          # WRONG (different convention)
```

```typescript
// Same principle in TypeScript
const fetchUserData = async () => {}   // CORRECT (matches existing)
const fetch_user_data = async () => {} // WRONG (different convention)
```

## Imports

- Follow the existing import ordering (stdlib, third-party, local)
- Don't reorganize imports in files you didn't change
- Use the same import style as the rest of the codebase (absolute vs relative)
