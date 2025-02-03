# MockX

MockX は、開発者向けのオープンソース API Mocking ツールです。実際の API 実装を待つことなく、フロントエンド開発やテストをスムーズに進めるためのモック API を簡単に作成・管理できます。

## 特徴
- **動的な API Mocking**: ユーザー定義のエンドポイントを動的に作成可能
- **シンプルな UI**: フロントエンドで Mock API を簡単に管理
- **Heroku & Vercel による無料デプロイ**: 簡単にクラウド上で運用可能
- **PostgreSQL ベースのストレージ**: 安定したデータ管理
- **レートリミット・遅延シミュレーション**: API の動作テストに最適
- **GitHub Actions を活用した CI/CD**

## システム構成
MockX は以下のコンポーネントで構成されます。

- **バックエンド**: Go + Gin / PostgreSQL（Heroku でホスティング）
- **フロントエンド**: Next.js（Vercel でホスティング）
- **データストレージ**: Heroku Postgres（無料枠を活用）
- **CI/CD**: GitHub Actions（自動デプロイ）

## インストール & デプロイ
### ローカル環境
```sh
git clone https://github.com/yourusername/MockX.git
cd MockX
make setup  # 必要な環境をセットアップ
make run    # ローカルサーバー起動
```

### Heroku デプロイ
```sh
heroku create mockx-api
heroku addons:create heroku-postgresql:hobby-dev
heroku config:set ENV=production
heroku git:remote -a mockx-api
git push heroku main
```

## ライセンス
MockX は MIT ライセンスのもとで公開されています。

