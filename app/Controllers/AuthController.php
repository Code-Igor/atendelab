<?php

//importa a conexão com o banco de dados
require_once __DIR__ . '/../../config/database.php';

// importa funcoes auxiliares de autenticacao e sessao.
require_once __DIR__ . '/../Middleware/auth.php';

class AuthController {
    
    //armazena PDO
    private PDO $pdo;

    public function __construct() {
        // recupera conexão criada em database.php
        global $pdo;

        // disponibiliza a conexão para os metodos da classe
        $this->pdo = $pdo;
    }

    // prof: exibirLogin() = Login()
    // decidi deixar só login() para facilitar no routes (funcionou com sucesso)
    public function login(): void {
        // se o usuário já estiver logado, redireciona para o dashboard
        if (usuarioAutenticado()) {
            header('Location: ?controller=auth&action=dashboard');
            exit;
        }

        // recupera mensagens temporárias da sessao
        $erro = $_SESSION['erro_login'] ?? null;
        $mensagem = $_SESSION['mensagem'] ?? null;

        // remove as mensagens para que aparaçam somente um vez.
        unset($_SESSION['erro_login'], $_SESSION['mensagem']);

        // carrega a tela de login
        require __DIR__ . '/../Views/auth/login.php';
    }

    public function entrar():void {

        // permite executar o login somente por requisicao POST
        if($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: ?controller=auth&action=login');
            exit; 
        }

        // recupera os dados enviados pelo formulario
        $email = trim($_POST['email'] ?? '');
        $senha = $_POST['senha'] ?? '';
        
        // verifica se os campos obrigatorios foram preenchidos
        if ($email === '' || $senha === '') {
            $_SESSION['erro_login'] = 'Informe o e-mail e a senha.';

            header('Location: ?controller=auth&action=login');
        }

        // verifica se o email possui formato valido
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $_SESSION['erro_login'] = 'Informe um e-mail válido.';

            header('Location: ?controller=auth&action=login');
            exit;
        }

        // busca o usuário pelo email
        $sql = 'SELECT id, nome, email, senha, perfil, status
                FROM usuarios
                WHERE email=:email
                LIMIT 1';

        //prepara a consulta para evitar SQL injection
        $stmt = $this->pdo->prepare($sql);

        // substitui o parametro :email pelo valor informado
        $stmt->bindValue(':email', $email);

        // executa a consulta
        $stmt->execute();

        // recupera o usuario encontrado 
        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);


        //valida usuario existente, status ativo e senha correta
        if (
            !$usuario
            || $usuario['status'] !== 'ativo'
            || !password_verify($senha, $usuario['senha'])
        ) {
            $_SESSION['erro_login'] = 'E-mail ou senha inválidos';

            header('Location: ?controller=auth&action=login');
            exit;
        }

        // gera um novo id de sessão por segurança
        session_regenerate_id(true);

        // salva na sessão apenas os dados necessarios do usuario
        $_SESSION['usuario'] = [
            'id' => $usuario['id'],
            'nome' => $usuario['nome'],
            'email' => $usuario['email'],
            'perfil' => $usuario['perfil'],
        ];

        // redireciona para o dashboard
        header('Location: ?controller=auth&action=dashboard');
        exit;
    }

    public function dashboard(): void {
        //bloqueia o acesso caso o usuario nao esteja logado
        exigirAutenticacao();

        //recupera os dados do usuario autenticado.
        $usuario = usuarioAtual();

        // carrega pagina inteira
        require __DIR__ . '/../Views/dashboard/index.php';
    }

    public function logout(): void {
        //remoce os dados armazenados na sessoa
        $_SESSION = [];

        // remove o cookie da sessao, caso esteja sendo utilizado
        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();

            setcookie (
                session_name(),
                '',
                time() - 42000,
                $params['path'],
                $params['domain'],
                $params['secure'],
                $params['httponly']
            );
        }

        // encerra sessao atual
        session_destroy();

        // inicia nova sessao apenas para enviar a mensagem de retorno
        session_start();

        // mensagem exibida apos logout
        $_SESSION['mensagem'] = 'Sessão encerrada com sucesso.';

        //retorna para a tela de login
        header('Location: ?controller=auth&action=login');
        exit;
    }
}

?>