# MockX API リファレンス

このドキュメントでは、MockX の API エンドポイントとリクエスト/レスポンス仕様について説明します。

## **1. エンドポイント一覧**
| Method | Endpoint | 説明 |
|--------|---------|------|
| `POST` | `/mocks` | Mock API を新規作成 |
| `GET` | `/mocks` | Mock API の一覧取得 |
| `GET` | `/mocks/{id}` | 指定した Mock API の取得 |
| `PUT` | `/mocks/{id}` | Mock API の更新 |
| `DELETE` | `/mocks/{id}` | Mock API の削除 |
| `POST` | `/mocks/{id}/simulate` | Mock API のシミュレーション（動作確認） |
| `GET` | `/logs` | リクエスト履歴の取得 |
| `DELETE` | `/logs` | リクエスト履歴のクリア |

---

## **2. Mock API のリクエスト / レスポンス仕様**

### **(1) Mock API 作成**
（省略）

---

### **(2) Mock API 取得**
（省略）

---

### **(3) Mock API 一覧取得**
**リクエスト**
```json
GET /mocks
```

**レスポンス**
```json
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": "uuid-12345",
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
    "delay": 500,
    "rateLimit": 10,
    "createdAt": "2025-02-03T12:00:00Z",
    "updatedAt": "2025-02-03T12:00:00Z"
  }
]
```

---

### **(4) Mock API 更新**
**リクエスト**
```json
PUT /mocks/{id}
Content-Type: application/json

{
  "method": "POST",
  "path": "/api/users",
  "response": {
    "status": 201,
    "headers": {
      "Content-Type": "application/json"
    },
    "body": {
      "id": 2,
      "name": "Jane Doe"
    }
  },
  "delay": 300
}
```

**レスポンス**
```json
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": "uuid-12345",
  "method": "POST",
  "path": "/api/users",
  "response": {
    "status": 201,
    "headers": {
      "Content-Type": "application/json"
    },
    "body": {
      "id": 2,
      "name": "Jane Doe"
    }
  },
  "delay": 300,
  "rateLimit": 10,
  "createdAt": "2025-02-03T12:00:00Z",
  "updatedAt": "2025-02-03T12:30:00Z"
}
```

---

### **(5) Mock API 削除**
**リクエスト**
```json
DELETE /mocks/{id}
```

**レスポンス**
```json
HTTP/1.1 204 No Content
```

---

### **(6) Mock API シミュレーション**
**リクエスト**
```json
POST /mocks/{id}/simulate
```

**レスポンス**
```json
HTTP/1.1 200 OK
Content-Type: application/json

{
  "status": 200,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": {
    "id": 1,
    "name": "John Doe"
  }
}
```

---

### **(7) リクエスト履歴の取得**
**リクエスト**
```json
GET /logs
```

**レスポンス**
```json
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": "log-67890",
    "mockId": "uuid-12345",
    "request": {
      "method": "GET",
      "path": "/api/users"
    },
    "response": {
      "status": 200
    },
    "timestamp": "2025-02-03T12:45:00Z"
  }
]
```

---

### **(8) リクエスト履歴のクリア**
**リクエスト**
```json
DELETE /logs
```

**レスポンス**
```json
HTTP/1.1 204 No Content
```

