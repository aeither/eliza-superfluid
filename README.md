# Eliza

## Configure Character

### Edit Default Character

Open `src/character.ts` to modify the default character. Uncomment and edit as needed.

### Load Custom Characters

- Use `pnpm start --characters="characters/eliza.character.json"`
- Load multiple character files simultaneously

### Add Clients

```typescript
// In character.ts
clients: [Clients.TWITTER, Clients.DISCORD];

// In character.json
"clients": ["twitter", "discord"]
```

## Environment Setup

### Create .env File

```bash
cp .env.example .env
```

Fill out the .env file with your specific values.

### Add Credentials and API Keys

```plaintext
DISCORD_APPLICATION_ID="your-discord-app-id"
DISCORD_API_TOKEN="your-discord-token"
OPENROUTER_API_KEY="your-openrouter-key"
TWITTER_USERNAME="your-twitter-username"
TWITTER_PASSWORD="your-twitter-password"
TWITTER_EMAIL="your-twitter-email"
```

## Installation and Execution

### Install Dependencies and Start Agent

```bash
pnpm i && pnpm start
```

Note: Requires Node.js version 22 or higher.

## Docker Deployment

### For x86_64 Architecture

1. Edit docker-compose.yaml:
   ```yaml
   services:
     eliza:
       environment:
         - OPENROUTER_API_KEY=your-api-key-here
   ```
2. Run:
   ```bash
   docker compose up
   ```

### For Mac M-Series or aarch64

1. Build image:
   ```bash
   docker buildx build --platform linux/amd64 -t eliza-starter:v1 --load .
   ```
2. Edit docker-compose-image.yaml:
   ```yaml
   services:
     eliza:
       environment:
         - OPENROUTER_API_KEY=your-api-key-here
   ```
3. Run:
   ```bash
   docker compose -f docker-compose-image.yaml up
   ```
