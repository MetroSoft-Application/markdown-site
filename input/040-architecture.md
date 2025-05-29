# 🏗️ アーキテクチャ

![アーキテクチャ図](../images/architecture-diagram.svg)

## システム概要

このシステムは以下のコンポーネントで構成されています。

## コンポーネント構成

### フロントエンド
- React.js ベースのユーザーインターフェース
- TypeScript による型安全性

### バックエンド
- Node.js + Express サーバー
- REST API エンドポイント

詳細なAPI仕様は [API仕様](./api-reference.md) を参照してください。

### データベース
- PostgreSQL によるデータ永続化
- Redis によるキャッシュ機能

![データフロー図](../images/data-flow.svg)

## セキュリティ

- JWT トークンによる認証
- HTTPS 通信の強制
- CORS ポリシーの適用

## パフォーマンス

パフォーマンス最適化の詳細は [開発者ガイド](./developer-guide.md) を参照してください。

## デプロイメント

システムのデプロイメント構成については、開発者ガイドを参照してください。

---

## ナビゲーション

- [🏠 ホーム](./README.md)
- [📋 概要](./overview.md)
- [🔧 API仕様](./api-reference.md)
- [👥 開発者ガイド](./developer-guide.md)
