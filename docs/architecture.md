# MockX システムアーキテクチャ

このドキュメントでは、MockX のシステムアーキテクチャについて説明します。

## 全体構成
MockX は以下のコンポーネントで構成されています。

- **バックエンド**: Go + Gin（APIサーバー）
- **データベース**: Heroku Postgres（無料枠利用）
- **フロントエンド**: Next.js（Vercel でホスティング）
- **CI/CD**: GitHub Actions による自動デプロイ
- **APIドキュメント**: Swagger + GitHub Pages

## システムフロー
1. **ユーザーがフロントエンドから API を登録**
   - Next.js の UI から API のパス、レスポンスデータを設定
2. **バックエンドがリクエストを受け取り、データベースに保存**
   - Gin フレームワークを使用して API リクエストを処理
   - PostgreSQL に保存
3. **Mock API が動的にエンドポイントを提供**
   - 事前に登録された API 定義に基づき、リクエストを動的に処理
4. **API のリクエストログを記録（将来的に分析機能を追加予定）**
5. **CI/CD による自動デプロイ**
   - GitHub Actions による Heroku + Vercel へのデプロイ

## データモデル
Mock API の定義は以下のようなデータ構造で管理されます。

```json
{
  "id": "uuid",
  "method": "GET",
  "path": "/api/users",
  "response": {
    "status": 200,
    "headers": {
      "Content-Type": "application/json"
    },
    "body": {
      "id": 1,
      "name": "John Doe"
    }
  },
  "createdAt": "2025-02-03T12:00:00Z",
  "updatedAt": "2025-02-03T12:30:00Z"
}
```

## 今後の拡張予定
- **認証機能（APIキー方式 or JWT）**
- **動的なレスポンス生成（リクエスト内容に応じたレスポンス）**
- **リクエストログの可視化ダッシュボード**
- **レートリミット・遅延設定のUI対応**

このアーキテクチャを基に開発を進めていきます。

