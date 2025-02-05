# Use a multi-stage build to compile for ARM64 while avoiding slow ARM emulation

# Builder Stage – run on amd64 to speed up the build process
FROM --platform=linux/amd64 node:23.7.0-slim AS builder

# Install build dependencies
RUN apt-get update && \
    apt-get install -y python3 make g++ libudev-dev libusb-1.0-0-dev git libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev && \
    npm install -g pnpm@9.15.1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ensure the python command is available
RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /app

# Copy application source and configuration files
COPY package.json pnpm-lock.yaml tsconfig.json ./
COPY src/ ./src/

# Install dependencies and build the application
RUN pnpm install --frozen-lockfile
RUN pnpm build

# Prepare built files – adjust permissions and directories as needed
RUN mkdir -p /app/dist && \
    chown -R node:node /app && \
    chmod -R 755 /app

# Switch to non-root user for the builder stage if needed
USER node

# Final Stage – use an ARM64 base image so the final image is ARM‑compatible
FROM arm64v8/node:23.7.0-slim

# Install runtime dependencies
RUN apt-get update && \
    apt-get install -y libudev1 libusb-1.0-0 libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgif7 librsvg2-2 && \
    npm install -g pnpm@9.15.1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy files from the builder stage into the final ARM image
COPY --from=builder /app/package.json /app/
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/src /app/src
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/tsconfig.json /app/
COPY --from=builder /app/pnpm-lock.yaml /app/

EXPOSE 3000
CMD ["pnpm", "start", "--non-interactive"]
