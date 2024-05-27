-- Crear la tabla para descripción de GPG SUBKEY
CREATE TABLE IF NOT EXISTS GPG_SUBKEYS (
    master_id TEXT NOT NULL,
    subkey_id TEXT NOT NULL UNIQUE,
    description TEXT,
    subkey_type INTEGER DEFAULT 0,
    visibility BOOLEAN,
    delivered_date TIMESTAMP,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by TEXT DEFAULT CURRENT_USER,
    modified_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_by TEXT DEFAULT CURRENT_USER,
    PRIMARY KEY (subkey_id)
);
