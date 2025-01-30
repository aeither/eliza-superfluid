# Use a specific Node.js version for better reproducibility
FROM node:23.3.0-slim AS builder

# Install pnpm globally and install necessary build tools
RUN npm install -g pnpm@9.15.1 && \
    apt-get update && \
    apt-get install -y git python3 make g++ curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Python 3 as the default python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Set the working directory
WORKDIR /app

# Copy package.json and other configuration files
COPY package.json ./
COPY pnpm-lock.yaml ./
COPY tsconfig.json ./

# Copy the rest of the application code
COPY ./src ./src
COPY ./characters ./characters

# Install dependencies and build the project
RUN pnpm install --frozen-lockfile
RUN pnpm build 

# Create dist directory and set permissions
RUN mkdir -p /app/dist && \
    chown -R node:node /app && \
    chmod -R 755 /app

# Switch to node user
USER node

# Create a new stage for the final image
FROM node:23.3.0-slim

# Install runtime dependencies if needed
RUN npm install -g pnpm@9.15.1
RUN apt-get update && \
    apt-get install -y git python3 curl sqlite3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SQLite vector extension in the final image
RUN curl -L https://github.com/asg017/sqlite-vss/releases/download/v0.1.2/sqlite-vss-linux-aarch64.tar.gz -o sqlite-vss.tar.gz && \
    tar -xvf sqlite-vss.tar.gz && \
    mkdir -p /usr/local/lib/sqlite-extensions && \
    mv libsqlite_vss0.so /usr/local/lib/sqlite-extensions/ && \
    rm sqlite-vss.tar.gz

# Install sqlite-vec extension
RUN git clone https://github.com/asg017/sqlite-vec.git && \
    cd sqlite-vec && \
    make && \
    make install && \
    cd .. && \
    rm -rf sqlite-vec

WORKDIR /app

# Copy built artifacts and production dependencies from the builder stage
COPY --from=builder /app/package.json /app/
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/src /app/src
COPY --from=builder /app/characters /app/characters
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/tsconfig.json /app/
COPY --from=builder /app/pnpm-lock.yaml /app/

# Set environment variable for SQLite extensions
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/sqlite-extensions:$LD_LIBRARY_PATH

EXPOSE 3000
# Set the command to run the application
CMD ["pnpm", "start", "--non-interactive"]
