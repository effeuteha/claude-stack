# Testing Conventions

- Write tests for new features before marking them complete
- Use descriptive test names: `test_user_login_with_expired_token_returns_401`
- Mock external services, not internal modules
- Each test should test one thing
- Use factories/fixtures for test data, not hardcoded values

## Test Structure

```python
# CORRECT — descriptive name, single assertion, clear arrange/act/assert
def test_create_task_with_missing_title_returns_422():
    response = client.post("/tasks", json={"description": "no title"})
    assert response.status_code == 422

# WRONG — vague name, multiple unrelated assertions
def test_tasks():
    response = client.post("/tasks", json={...})
    assert response.status_code == 201
    response = client.get("/tasks")
    assert len(response.json()) > 0
```

## What to Test

- Happy path + common error cases
- Input validation (missing fields, wrong types, boundary values)
- Authorization (authenticated vs unauthenticated, own data vs others')
- Don't test framework behavior (e.g., don't test that FastAPI returns 404 for missing routes)
