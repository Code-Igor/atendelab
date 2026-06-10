<?php

// controller da entidade pessoas

class PessoasController {
    private PDO $pdo;

    public function __construct() {
        require __DIR__ . '\..\..\config\database.php';
        $this->pdo = $pdo;
    }

    public function listar(): void {
        header('Content-Type: application/json; charset=utf-8');

        $sql = 'SELECT * 
                FROM pessoas
                ORDER BY id DESC';

        $stmt = $this->pdo->query($sql);
        $usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($usuarios, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }

    public function buscarPorId(): void {
        header('Content-Type: application/json; charset=utf-8');
    }

    public function criar(): void {
        header('Content-Type: application/json; charset=utf-8');
    }

    public function atualizar(): void {
        header('Content-Type: application/json; charset=utf-8');
    }

    public function excluir(): void {
        header('Content-Type: application/json; charset=utf-8');
    }
}

?>