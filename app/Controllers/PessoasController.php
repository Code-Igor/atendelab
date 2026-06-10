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