# ⚙️ 設定

![設定](../images/configuration.svg)

このページでは、システムの各種設定方法について説明します。

## 環境設定

### 環境変数

```bash
# .env ファイルの例
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://username:password@localhost:5432/dbname
REDIS_URL=redis://localhost:6379
JWT_SECRET=your-super-secret-jwt-key
```

### データベース設定

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

## アプリケーション設定

### ログ設定

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

### キャッシュ設定

Redis キャッシュの設定については [アーキテクチャ](./architecture.md) で詳細を確認してください。

```typescript
// cache.config.ts
export const cacheConfig = {
  ttl: 3600, // 1時間
  maxKeys: 1000,
  redis: {
    host: process.env.REDIS_HOST || 'localhost',
    port: parseInt(process.env.REDIS_PORT || '6379'),
    db: 0
  }
};
```

## セキュリティ設定

### JWT設定

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

### CORS設定

```typescript
// cors.config.ts
export const corsConfig = {
  origin: process.env.ALLOWED_ORIGINS?.split(',') || ['http://localhost:3000'],
  credentials: true,
  optionsSuccessStatus: 200
};
```

## 本番環境設定

### Docker設定

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

### 環境変数（本番）

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

## ナビゲーション

- [🏠 ホーム](./README.md)
- [🚀 始め方](./getting-started.md)
- [🏗️ アーキテクチャ](./architecture.md)
- [❓ FAQ](./faq.md)
