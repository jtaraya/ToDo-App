#!/bin/bash

# Create lib/prisma.ts
cat > lib/prisma.ts << 'EOF'
import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined
}

export const prisma = globalForPrisma.prisma ?? new PrismaClient()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma
EOF

echo "✓ Created lib/prisma.ts"

# Download the files from the package I gave you and copy them:
# - TodoList.tsx → app/components/TodoList.tsx  
# - api-route.ts → app/api/todos/route.ts
# - page.tsx → app/page.tsx

echo "Setup complete! Now copy the remaining files manually."
