CREATE TABLE IF NOT EXISTS tokens (
    id INT(10) AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    user_id INT(10),
    token VARCHAR(300) NOT NULL,
    token_hash BLOB NOT NULL,
    expired_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);