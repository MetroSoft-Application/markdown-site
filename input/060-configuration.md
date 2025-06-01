# ⚙️ Configuration

![Configuration](../images/configuration.svg)

This page explains the various configuration methods for the system.

## Environment Setup

### Environment Variables

```bash
# Example .env file
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://username:password@localhost:5432/dbname
REDIS_URL=redis://localhost:6379
JWT_SECRET=your-super-secret-jwt-key
```

### Database Configuration

```typescript
// database.config.ts
export const databaseConfig = {
  development: {
    host: 'localhost',
    port: 5432,
    database: 'markdown_dev',
    username: 'dev_user',
    password: 'dev_password'
  },
  production: {
    host: process.env.DB_HOST,
    port: parseInt(process.env.DB_PORT || '5432'),
    database: process.env.DB_NAME,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD
  }
};
```

## Application Configuration

### Logging Configuration

```json
{
  "logging": {
    "level": "info",
    "format": "json",
    "outputs": ["console", "file"],
    "file": {
      "path": "./logs/app.log",
      "maxSize": "10MB",
      "maxFiles": 5
    }
  }
}
```

### Cache Configuration

For Redis cache configuration details, please check [Architecture](./040-architecture.md).

```typescript
// cache.config.ts
export const cacheConfig = {
  ttl: 3600, // 1 hour
  maxKeys: 1000,
  redis: {
    host: process.env.REDIS_HOST || 'localhost',
    port: parseInt(process.env.REDIS_PORT || '6379'),
    db: 0
  }
};
```

## Security Configuration

### JWT Configuration

```typescript
// auth.config.ts
export const authConfig = {
  jwt: {
    secret: process.env.JWT_SECRET,
    expiresIn: '24h',
    algorithm: 'HS256'
  },
  bcrypt: {
    saltRounds: 12
  }
};
```

### CORS Configuration

```typescript
// cors.config.ts
export const corsConfig = {
  origin: process.env.ALLOWED_ORIGINS?.split(',') || ['http://localhost:3000'],
  credentials: true,
  optionsSuccessStatus: 200
};
```

## Production Environment Configuration

### Docker Configuration

```dockerfile
# Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### Environment Variables (Production)

```bash
# production.env
NODE_ENV=production
PORT=3000
DATABASE_URL=postgresql://prod_user:prod_pass@db:5432/markdown_prod
REDIS_URL=redis://cache:6379
JWT_SECRET=super-secure-production-secret
LOG_LEVEL=warn
```

---

## Navigation

- [🏠 Home](./010-README.md)
- [🚀 Getting Started](./030-getting-started.md)
- [🏗️ Architecture](./040-architecture.md)
- [❓ FAQ](./100-faq.md)
