# Testing Conventions

- Write tests for new features before marking them complete
- Use descriptive test names: `test_user_login_with_expired_token_returns_401`
- Mock external services, not internal modules
- Each test should test one thing
- Use factories/fixtures for test data, not hardcoded values
