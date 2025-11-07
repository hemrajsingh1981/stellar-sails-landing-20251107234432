# ---- Base Node ----
# Get a small Node.js image
FROM node:18-alpine AS base

# ---- Dependencies ----
# Install dependencies in a separate layer to leverage Docker cache
FROM base AS deps
WORKDIR /app

# Install dependencies based on the lock file
COPY package.json package-lock.json* ./
RUN npm ci

# ---- Builder ----
# Build the Next.js application
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Environment variables must be set at build time
# These ARG and ENV instructions are added based on NEXT_PUBLIC_ variables found in the source code.

# ---- Runner ----
# Final, small image for running the application
FROM base AS runner
WORKDIR /app

# Create a non-root user for security
ENV NODE_ENV=production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy the standalone Next.js server, public assets, and static files
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000

# Run the Next.js server
CMD ["node", "server.js"]
