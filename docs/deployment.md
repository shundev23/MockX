# MockX デプロイメントガイド

このドキュメントでは、MockX をデプロイするための手順を説明します。

## ホスティング戦略
MockX は以下の無料プラットフォームを利用してホスティングされます。

### **バックエンド: Heroku**
- **理由**: Heroku は無料プランで Go アプリをホスティングでき、Heroku Postgres も無料枠で利用可能。
- **デプロイ手順**:
  1. Heroku アカウントを作成し、CLI をインストール
  2. Heroku アプリを作成
     ```sh
     heroku create mockx-api
     ```
  3. PostgreSQL アドオンを追加
     ```sh
     heroku addons:create heroku-postgresql:hobby-dev
     ```
  4. 環境変数を設定
     ```sh
     heroku config:set ENV=production
     ```
  5. GitHub リポジトリと連携してデプロイ
     ```sh
     heroku git:remote -a mockx-api
     git push heroku main
     ```

### **フロントエンド: Vercel**
- **理由**: Vercel は Next.js 向けの最適なホスティングを無料で提供。
- **デプロイ手順**:
  1. Vercel アカウントを作成
  2. GitHub リポジトリを Vercel に接続
  3. `vercel.json` を設定（必要に応じて）
  4. デプロイを実行

### **CI/CD: GitHub Actions**
- **理由**: GitHub Actions を活用することで、自動的にデプロイを実行可能。
- **設定手順**:
  1. `.github/workflows/deploy.yml` を作成
  2. Heroku と Vercel のデプロイジョブを追加
  3. `secrets` に API トークンを登録

このガイドに沿って設定すれば、MockX を無料で運用可能です。