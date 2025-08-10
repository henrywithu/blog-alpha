# Use official Node.js LTS image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* pnpm-lock.yaml* yarn.lock* ./
RUN if [ -f package-lock.json ]; then npm ci; \
    elif [ -f pnpm-lock.yaml ]; then npm install -g pnpm && pnpm install; \
    elif [ -f yarn.lock ]; then yarn install; \
    else npm install; fi

# Copy the rest of the application
COPY . .

# Build the Next.js app
RUN npm run build

# Expose port (default for Next.js)
EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]