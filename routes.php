<?php

// carrega os controllers 
require_once __DIR__ . '/app/Controllers/UsuariosController.php';
require_once __DIR__ . '/app/Controllers/PessoasController.php';
require_once __DIR__ . '/app/Controllers/AuthController.php';
require_once __DIR__ . '/app/Controllers/TiposAtendimentosController.php';
require_once __DIR__ . '/app/Controllers/AtendimentosController.php';
require_once __DIR__ . '/app/Middleware/auth.php';

// define controller e action por query string
// exemplo: ?controller=usuarios&action=listar
$controllerName = $_GET['controller'] ?? 'auth';
$action = $_GET['action'] ?? 'login';

// o nome da classe do controller em si, para a validação do class_exists
// exemplo: transforma usuarios em UsuariosController
$controllerClass = ucfirst($controllerName) . 'Controller';


// verifica se a classe existe
if (!class_exists($controllerClass)) {
    http_response_code(400);
    echo json_encode(['erro' => 'Controller nao encontrado.']);
    exit;
} 

// instancia do controller, que pode receber qualquer contorller
$controllerInstance = new $controllerClass();
    
// verifica se o método existe
if (!method_exists($controllerInstance, $action)) {
    http_response_code(400);
    echo json_encode(['erro' => 'Action nao encontrado.']);
    exit;
} 
    
// executa o método 
$controllerInstance->$action();

?>