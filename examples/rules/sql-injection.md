# SQL Injection Prevention

ALWAYS use parameterized queries for user input:

```python
# CORRECT
sql = "SELECT * FROM users WHERE email = %(email)s"
result = db.execute(sql, {"email": sanitized_email})

# WRONG - SQL injection vulnerable
sql = f"SELECT * FROM users WHERE email = '{email}'"
```

ALWAYS sanitize LIKE patterns:
```python
sanitized = query.replace("\\", "\\\\").replace("%", "\\%").replace("_", "\\_")
```
