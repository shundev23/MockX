# ベースイメージとして公式の Go イメージを使用
FROM golang:1.20 AS builder

# 作業ディレクトリを作成
WORKDIR /app/backend

# Go モジュールと依存関係をコピー
COPY backend/go.mod backend/go.sum ./
# changed
RUN go mod download

# アプリケーションのソースコードをコピー
COPY . .

# Go アプリをビルド
RUN go build -o app backend/cmd/main.go

# 実行用の軽量なコンテナイメージを作成
FROM alpine:latest

WORKDIR /root/

# 必要なランタイムをインストール
RUN apk --no-cache add ca-certificates

# ビルドしたバイナリをコピー
COPY --from=builder /app/app .

# ポートを公開
EXPOSE 8080

# アプリを実行
CMD ["./app"]
