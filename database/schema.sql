CREATE DATABASE iptv_db;
USE iptv_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(10) DEFAULT 'admin'
);

INSERT INTO users (username, password) VALUES
('admin', '$2y$10$3hzJNRPgjE6jSRNYziO5qeS7UBJRSzJw0HSt0U5fLFBjoc5vRtIJS');

CREATE TABLE channels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    url TEXT NOT NULL,
    group_title VARCHAR(100)
);