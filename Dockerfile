# First stage - fastembed layer
FROM h4ckermike/fastembed-js:feature-arm64_v2 AS fastembed

# Install Rust and build tools
RUN apt-get update && \
    apt-get install -y curl pkg-config libssl-dev build-essential && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add cargo to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Install pnpm and install dependencies to get the ARM64 tokenizers
RUN cd /node_modules/fastembed && pnpm install

# Build the tokenizers
RUN cd /node_modules/fastembed/node_modules/@anush008/tokenizers && \
    cargo build && \
    cp /node_modules/fastembed/node_modules/@anush008/tokenizers/target/debug/libanush008_tokenizers.so /node_modules/fastembed/node_modules/@anush008/tokenizers/tokenizers.linux-arm64-gnu.node

# Second stage - builder
FROM node:23.3.0-slim AS builder

# Install pnpm globally and install necessary build tools
RUN npm install -g pnpm@9.4.0 && \
    apt-get update && \
    apt-get install -y git python3 make g++ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Python 3 as the default python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Set the working directory
WORKDIR /app

# Copy package.json and other configuration files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml .npmrc turbo.json ./

# Copy the rest of the application code
COPY src ./src

# Install dependencies and build the project
RUN pnpm install && \
    pnpm build && \
    pnpm prune --prod

# Create directories for tokenizers
RUN mkdir -p /app/node_modules/@anush008/tokenizers

# Copy the ARM64 tokenizers from the fastembed stage to both locations
COPY --from=fastembed /node_modules/fastembed/node_modules/@anush008/tokenizers/tokenizers.linux-arm64-gnu.node /app/node_modules/@anush008/tokenizers/

# Make sure the binaries are executable
RUN chmod +x /app/node_modules/@anush008/tokenizers/tokenizers.linux-arm64-gnu.node

# Final stage
FROM node:23.3.0-slim

# Install runtime dependencies if needed
RUN npm install -g pnpm@9.4.0 && \
    apt-get update && \
    apt-get install -y git python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy built artifacts and production dependencies from the builder stage
COPY --from=builder /app/package.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/tsconfig.json ./tsconfig.json
COPY --from=builder /app/pnpm-lock.yaml ./pnpm-lock.yaml

# Set the command to run the application
CMD ["pnpm", "start"]