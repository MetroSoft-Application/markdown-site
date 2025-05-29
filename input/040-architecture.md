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

詳細なAPI仕様は [API仕様](./050-api-reference.html) を参照してください。

### データベース
- PostgreSQL によるデータ永続化
- Redis によるキャッシュ機能

![データフロー図](../images/data-flow.svg)

## セキュリティ

- JWT トークンによる認証
- HTTPS 通信の強制
- CORS ポリシーの適用

## パフォーマンス

パフォーマンス最適化の詳細は [開発者ガイド](./070-developer-guide.html) を参照してください。

## デプロイメント

システムのデプロイメント構成については、開発者ガイドを参照してください。

---

## ナビゲーション

- [🏠 ホーム](./010-README.html)
- [📋 概要](./020-overview.html)
- [🔧 API仕様](./050-api-reference.html)
- [👥 開発者ガイド](./070-developer-guide.html)
