---
description: "Deploy the application to the specified environment"
argument-hint: "[environment: staging|production]"
---

Deploy the application to the `$ARGUMENTS` environment.

Steps:
1. Run the full test suite. If any tests fail, stop and report.
2. Build the application for production.
3. Show me the build output and ask for confirmation before deploying.
4. Deploy to the specified environment.
5. Verify the deployment is healthy by checking the health endpoint.

If no environment is specified, default to staging.
