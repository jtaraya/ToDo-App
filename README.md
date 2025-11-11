# Full-Stack To-Do List Application

A modern, fully functional to-do list application built with Next.js 14, TypeScript, Prisma, and SQLite.

## Features

✅ **Add Tasks** - Create new to-do items with title and description
✅ **Mark Complete** - Check off completed tasks
✅ **Edit Tasks** - Modify existing tasks
✅ **Delete Tasks** - Remove tasks you no longer need
✅ **Persistent Storage** - All data saved to SQLite database
✅ **Real-time Updates** - Instant UI updates
✅ **Responsive Design** - Works on desktop, tablet, and mobile
✅ **Beautiful UI** - Modern design with Tailwind CSS

## Tech Stack

- **Frontend**: Next.js 14 (App Router), React, TypeScript
- **Backend**: Next.js API Routes
- **Database**: SQLite with Prisma ORM
- **Styling**: Tailwind CSS

## Prerequisites

- Node.js 18+ installed
- npm or yarn package manager
- Basic command line knowledge

## Quick Start

### 1. Create Next.js Project

```bash
npx create-next-app@latest todo-app
cd todo-app
```

When prompted, select:
- ✔ TypeScript: **Yes**
- ✔ ESLint: **Yes**
- ✔ Tailwind CSS: **Yes**
- ✔ `src/` directory: **No**
- ✔ App Router: **Yes**
- ✔ Import alias: **No**

### 2. Install Dependencies

```bash
npm install prisma @prisma/client
npm install -D prisma
```

### 3. Initialize Prisma

```bash
npx prisma init --datasource-provider sqlite
```

### 4. Set Up Project Files

Copy the files I've provided into your project:

**File Structure:**
```
todo-app/
├── app/
│   ├── api/
│   │   └── todos/
│   │       └── route.ts          ← Copy from api-route.ts
│   ├── components/
│   │   └── TodoList.tsx          ← Copy from TodoList.tsx
│   └── page.tsx                  ← Copy from page.tsx
├── lib/
│   └── prisma.ts                 ← Copy from lib-prisma.ts
├── prisma/
│   └── schema.prisma             ← Copy from prisma-schema.prisma
├── .env                          ← Copy from env-example.txt
└── package.json
```

**Important**: Create these directories if they don't exist:
```bash
mkdir -p app/api/todos
mkdir -p app/components
mkdir -p lib
```

### 5. Create Database

```bash
npx prisma migrate dev --name init
npx prisma generate
```

### 6. Run the Application

```bash
npm run dev
```

Open http://localhost:3000 in your browser! 🎉

## File Details

### 1. `/prisma/schema.prisma` (Database Schema)
Defines the Todo model with fields:
- id: Unique identifier
- title: Task title (required)
- description: Task description (optional)
- completed: Completion status
- createdAt: Creation timestamp
- updatedAt: Last update timestamp

### 2. `/lib/prisma.ts` (Database Client)
Sets up Prisma client for database operations. Prevents multiple instances in development.

### 3. `/app/api/todos/route.ts` (Backend API)
Handles all CRUD operations:
- **GET**: Fetch all todos
- **POST**: Create new todo
- **PATCH**: Update todo (completion status or edit)
- **DELETE**: Delete todo

### 4. `/app/components/TodoList.tsx` (Frontend Component)
Main React component with:
- Task creation form
- Task list display
- Inline editing
- Completion toggle
- Delete functionality
- Loading states

### 5. `/app/page.tsx` (Main Page)
Simple entry point that renders the TodoList component.

### 6. `/.env` (Environment Variables)
Contains database connection string for SQLite.

## How It Works

### Data Flow

1. **User Action** → Frontend (TodoList.tsx)
2. **API Call** → Backend (route.ts)
3. **Database Operation** → Prisma → SQLite
4. **Response** → Frontend → UI Update

### Example: Adding a Task

```
User clicks "Add Task"
    ↓
TodoList.tsx sends POST request to /api/todos
    ↓
route.ts receives request, validates data
    ↓
Prisma creates record in SQLite database
    ↓
New todo returned to frontend
    ↓
UI updates to show new task
```

## API Endpoints

### GET /api/todos
Fetch all todos, ordered by creation date (newest first)

### POST /api/todos
Create a new todo
```json
{
  "title": "Buy groceries",
  "description": "Milk, eggs, bread"
}
```

### PATCH /api/todos
Update a todo (toggle completion or edit)
```json
{
  "id": "clxxx...",
  "completed": true
}
```
OR
```json
{
  "id": "clxxx...",
  "title": "Updated title",
  "description": "Updated description"
}
```

### DELETE /api/todos?id=clxxx...
Delete a specific todo

## Database Commands

```bash
# View database in browser
npx prisma studio

# Create migration after schema changes
npx prisma migrate dev --name description

# Reset database (delete all data)
npx prisma migrate reset

# Generate Prisma client after schema changes
npx prisma generate
```

## Customization Ideas

### 1. Add Priority Levels
```prisma
model Todo {
  // ... existing fields
  priority String @default("medium") // low, medium, high
}
```

### 2. Add Due Dates
```prisma
model Todo {
  // ... existing fields
  dueDate DateTime?
}
```

### 3. Add Categories/Tags
```prisma
model Todo {
  // ... existing fields
  category String?
}
```

### 4. Add User Authentication
Consider adding NextAuth.js for multi-user support

### 5. Deploy to Production
- **Vercel**: Easiest deployment for Next.js
- **Railway**: Great for apps with databases
- **Render**: Good for full-stack apps

## Troubleshooting

### "Prisma Client not generated"
```bash
npx prisma generate
```

### Port 3000 already in use
```bash
npx kill-port 3000
# or
npm run dev -- -p 3001
```

### Database locked error
Close Prisma Studio if running:
```bash
# Find and kill the process
lsof -i :5555
```

### Changes not reflecting
```bash
# Clear cache and restart
rm -rf .next
npm run dev
```

## Production Deployment

### Using Vercel (Recommended)

1. Push your code to GitHub
2. Import project on vercel.com
3. Vercel auto-detects Next.js
4. For production, switch to PostgreSQL:

```bash
# Install PostgreSQL client
npm install @prisma/client

# Update prisma/schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

# Update .env with PostgreSQL URL
DATABASE_URL="postgresql://..."

# Run migration
npx prisma migrate deploy
```

## Performance Tips

1. **Database Indexing**: Add indexes to frequently queried fields
2. **Caching**: Implement React Query for client-side caching
3. **Pagination**: Add pagination for large todo lists
4. **Optimistic Updates**: Update UI before API response

## Security Considerations

1. **Input Validation**: Already implemented in API routes
2. **Rate Limiting**: Add rate limiting for production
3. **Authentication**: Add user auth for multi-user scenarios
4. **CORS**: Configure CORS if building separate frontend

## Next Steps

- [ ] Add user authentication
- [ ] Implement categories/tags
- [ ] Add due dates and reminders
- [ ] Create mobile app version
- [ ] Add data export/import
- [ ] Implement recurring tasks
- [ ] Add task sharing features

## Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Prisma Documentation](https://www.prisma.io/docs)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs)

## License

MIT License - Feel free to use this for personal or commercial projects!

---

**Happy Task Managing! 📝✨**

This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
