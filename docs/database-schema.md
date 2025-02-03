# MockX データベーススキーマ

このドキュメントでは、MockX のデータベーススキーマについて説明します。

## **1. テーブル構成**
| テーブル名 | 説明 |
|------------|------|
| `mocks` | Mock API の定義（エンドポイント情報） |
| `logs` | リクエスト履歴 |

---

## **2. `mocks` テーブル**
Mock API の基本データを保存するテーブル。

```sql
CREATE TABLE IF NOT EXISTS mocks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    method TEXT NOT NULL,
    path TEXT NOT NULL,
    response_status INTEGER NOT NULL,
    response_headers JSONB,
    response_body JSONB,
    delay INTEGER DEFAULT 0,
    rate_limit INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);
```

### **フィールド説明**
| フィールド | 型 | 説明 |
|-----------|------|---------------------------|
| `id` | `UUID` | Mock API の一意識別子 |
| `method` | `TEXT` | HTTP メソッド（GET, POST, etc.） |
| `path` | `TEXT` | Mock API のパス |
| `response_status` | `INTEGER` | 返すステータスコード |
| `response_headers` | `JSONB` | 返すレスポンスヘッダー |
| `response_body` | `JSONB` | 返すレスポンスボディ |
| `delay` | `INTEGER` | レスポンス遅延（ミリ秒） |
| `rate_limit` | `INTEGER` | 1分間のリクエスト制限 |
| `created_at` | `TIMESTAMP` | 作成日時 |
| `updated_at` | `TIMESTAMP` | 更新日時 |

---

## **3. `logs` テーブル**
Mock API へのリクエストログを保存するテーブル。

```sql
CREATE TABLE IF NOT EXISTS logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mock_id UUID REFERENCES mocks(id) ON DELETE CASCADE,
    request_method TEXT NOT NULL,
    request_path TEXT NOT NULL,
    request_headers JSONB,
    request_body JSONB,
    response_status INTEGER,
    response_headers JSONB,
    response_body JSONB,
    created_at TIMESTAMP DEFAULT now()
);
```

### **フィールド説明**
| フィールド | 型 | 説明 |
|-----------|------|---------------------------|
| `id` | `UUID` | リクエストログの一意識別子 |
| `mock_id` | `UUID` | 対応する Mock API の ID |
| `request_method` | `TEXT` | リクエストメソッド |
| `request_path` | `TEXT` | リクエストのパス |
| `request_headers` | `JSONB` | 送信されたヘッダー情報 |
| `request_body` | `JSONB` | 送信されたリクエストボディ |
| `response_status` | `INTEGER` | 返されたレスポンスコード |
| `response_headers` | `JSONB` | 返されたレスポンスヘッダー |
| `response_body` | `JSONB` | 返されたレスポンスボディ |
| `created_at` | `TIMESTAMP` | ログの作成日時 |

---

## **4. 設計のポイント**
- **UUID の利用**: `id` に `UUID` を使用することで一意性を担保。
- **JSONB 型の利用**: 可変データ（ヘッダー・ボディ）を柔軟に保存可能。
- **`ON DELETE CASCADE` の適用**: `logs` は `mocks` のデータが削除された際、自動で削除される。

このスキーマを基にデータベースを設計し、運用していきます。

