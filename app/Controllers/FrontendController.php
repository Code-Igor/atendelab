<?php

class FrontendController
{
    public function pessoas(): void
    {
        // direciona para a pagina
        require __DIR__ . '/../Views/pessoas/index.php';
    }

    public function tipos(): void
    {
        require __DIR__ . '/../Views/tipos-atendimentos/index.php';
    }

    public function atendimentos(): void
    {
        require __DIR__ . '/../Views/atendimentos/index.php';
    }
}


?>