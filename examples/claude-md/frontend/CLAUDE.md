# Frontend CLAUDE.md

<!--
  This file is lazily loaded only when Claude touches files in this directory.
  Put frontend-specific conventions here.
-->

## Component Conventions

- Use functional components with hooks (no class components)
- State management: [e.g., React Query for server state, useState for local]
- Styling: [e.g., Tailwind utility classes, no inline styles]

## File Structure

```
src/
├── components/     # Reusable UI components
├── pages/          # Route-level page components
├── lib/            # Utilities, API client
├── hooks/          # Custom React hooks
└── types/          # TypeScript interfaces
```

## API Client

```typescript
// Always use the api client, never raw fetch
import { api } from '@/lib/api';

// CORRECT
const data = await api.getUsers();

// WRONG
const data = await fetch('/api/users');
```
