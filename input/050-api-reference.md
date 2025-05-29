# 🔧 API仕様

![API仕様](../images/api-reference.svg)

このドキュメントでは、REST API の詳細仕様を説明します。

## ベースURL

```
https://api.example.com/v1
```

## 認証

すべてのAPIエンドポイントはJWTトークンによる認証が必要です。

```http
Authorization: Bearer {your-jwt-token}
```

## エンドポイント一覧

### ユーザー管理

#### GET /users

ユーザー一覧を取得します。

```http
GET /users
```

**レスポンス例:**

```json
{
  "users": [
    {
      "id": 1,
      "name": "太郎",
      "email": "taro@example.com"
    }
  ]
}
```

![APIレスポンス例](../images/api-response-example.svg)

#### POST /users

新しいユーザーを作成します。

```http
POST /users
Content-Type: application/json

{
  "name": "花子",
  "email": "hanako@example.com"
}
```

### データ管理

詳細なデータ管理方法は [開発者ガイド](./070-developer-guide.html) を参照してください。

## エラーハンドリング

APIエラーの詳細は [トラブルシューティング](./090-troubleshooting.html#APIエラー) をご覧ください。

![エラーコード一覧](../images/error-codes.svg)

---

## ナビゲーション

- [🏠 ホーム](./010-README.html)
- [🏗️ アーキテクチャ](./040-architecture.html)
- [👨‍💻 開発者ガイド](./070-developer-guide.html)
- [🔧 トラブルシューティング](./090-troubleshooting.html)
