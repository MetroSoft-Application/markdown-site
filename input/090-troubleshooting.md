# 🔧 トラブルシューティング

![トラブルシューティング](../images/troubleshooting.svg)

よくある問題と解決方法をまとめています。

## 一般的な問題

### サーバーが起動しない

**症状**: `npm start` でエラーが発生する

**解決方法**:
1. Node.js のバージョンを確認 (`node --version`)
2. 依存関係を再インストール (`npm install`)
3. 環境変数を確認 ([設定](./060-configuration.html) を参照)

```bash
# 依存関係のクリーンインストール
rm -rf node_modules package-lock.json
npm install
```

### データベース接続エラー

**症状**: `Database connection failed`

**解決方法**:
1. PostgreSQL が起動しているか確認
2. 接続文字列を確認
3. ファイアウォール設定を確認

```bash
# PostgreSQL の状態確認
systemctl status postgresql

# 接続テスト
psql -h localhost -U username -d database_name
```

## 開発環境の問題

### Hot Reload が動作しない

**解決方法**:
1. ファイル監視の設定を確認
2. ポート競合がないか確認
3. 開発サーバーを再起動

```bash
# 開発サーバーの再起動
npm run dev
```

### ビルドエラー

**症状**: TypeScript コンパイルエラー

**解決方法**:
1. `tsconfig.json` の設定を確認
2. 型定義ファイルを更新
3. キャッシュをクリア

```bash
# TypeScript キャッシュクリア
rm -rf dist/ .tscache/
npm run build
```

## APIエラー

### 401 Unauthorized

**原因**: 認証トークンの問題

**解決方法**:
1. トークンの有効期限を確認
2. JWT シークレットキーを確認
3. 再ログインを実行

### 404 Not Found

**原因**: エンドポイントが存在しない

**解決方法**:
1. [API仕様](./050-api-reference.html) でエンドポイントを確認
2. ルーティング設定を確認
3. サーバーログを確認

### 500 Internal Server Error

**原因**: サーバー内部エラー

**解決方法**:
1. サーバーログを確認
2. データベース接続を確認
3. エラースタックトレースを分析

```bash
# ログファイルの確認
tail -f logs/error.log
```

## パフォーマンス問題

### レスポンスが遅い

**解決方法**:
1. データベースクエリを最適化
2. キャッシュ設定を確認
3. [パフォーマンス最適化](./070-developer-guide.html#パフォーマンス最適化) を参照

### メモリ使用量が多い

**解決方法**:
1. メモリリークを確認
2. キャッシュサイズを調整
3. 不要なプロセスを終了

```bash
# メモリ使用量の確認
ps aux --sort=-%mem | head -10
```

## ネットワーク問題

### 接続タイムアウト

**解決方法**:
1. ネットワーク接続を確認
2. プロキシ設定を確認
3. DNSの動作を確認

```bash
# 接続テスト
curl -I http://localhost:3000/health
```

## Docker関連の問題

### コンテナが起動しない

**解決方法**:
1. Dockerファイルの構文を確認
2. ベースイメージを確認
3. ポートマッピングを確認

```bash
# コンテナログの確認
docker logs container_name

# コンテナの状態確認
docker ps -a
```

## ログとデバッグ

### ログレベルの調整

```bash
# 環境変数でログレベルを設定
export LOG_LEVEL=debug
npm start
```

### デバッグモードの有効化

```bash
# デバッグモードで起動
DEBUG=* npm run dev
```

## 緊急時の対応

### システム復旧手順

1. **バックアップからの復元**
   ```bash
   # データベース復元
   pg_restore -d database_name backup_file.sql
   ```

2. **ログの確認**
   ```bash
   # エラーログの確認
   grep -i error logs/*.log
   ```

3. **システム状態の確認**
   ```bash
   # プロセス確認
   ps aux | grep node
   # ポート使用状況
   netstat -tulpn | grep :3000
   ```

## サポート情報

問題が解決しない場合:

1. [FAQ](./100-faq.html) を確認
2. [開発者ガイド](./070-developer-guide.html) を参照
3. ログファイルを添付してサポートに連絡

---

## ナビゲーション

- [🏠 ホーム](./010-README.html)
- [⚙️ 設定](./060-configuration.html)
- [🔧 API仕様](./050-api-reference.html)
- [❓ FAQ](./100-faq.html)
