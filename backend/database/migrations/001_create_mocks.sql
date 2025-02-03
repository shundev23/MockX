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
