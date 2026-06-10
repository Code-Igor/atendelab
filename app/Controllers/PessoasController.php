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

        // lê e valida o ID recebido por GET
        $id = filter_input(INPUT_GET, 'id, FILTER_VALIDATE_INT');

        if(!$id) {
            http_response_code(400);
            echo json_encode(['erro' => 'ID inválido.']);
            return;
        }

        $sql = 'SELECT id, nome, documento, telefone, curso, periodo, criado em
                FROM pessoas
                WHERE id = :id';
        
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);
        $stmt->execute();

        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!usuario) {
            http_response_code(400);
            echo json_encode(['erro' => 'Pessoa não encontrada.']);
            return;
        }

        echo json_encode($usuario, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
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