-- criando banco de dados
CREATE DATABASE IF NOT EXISTS atendelab
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE atendelab;

-- criando as tabelas
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('admin', 'atendente') DEFAULT 'atendente',
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pessoas ( 
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    perfil ENUM('aluno', 'pessoa_atendida') DEFAULT 'pessoa_atendida',
    email VARCHAR(100) UNIQUE,
    numero VARCHAR(15) UNIQUE, 
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);


-- inserindo um usuário inicial para teste
INSERT INTO usuarios (nome, email, senha, perfil, status)
VALUES (
 'Administrador',
 'admin@atendelab.com',
 '$2y$10$J9P2kU2BAMZ3TZcuxTsW4e1D/lka8EocYHzvyoOZmCNcWDQz3RuVC',
 'admin',
 'ativo'
);
