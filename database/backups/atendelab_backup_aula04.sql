-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2026 at 12:15 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `atendelab`
--

-- --------------------------------------------------------

--
-- Table structure for table `atendimento`
--

CREATE TABLE `atendimentos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `tipo_atendimento_id` int(11) NOT NULL,
  `descricao` text DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_hora_atendimento` datetime DEFAULT NULL,
  `observacao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `atendimento`
--

INSERT INTO `atendimento` (`id`, `usuario_id`, `pessoa_id`, `tipo_atendimento_id`, `descricao`, `criado_em`, `data_hora_atendimento`, `observacao`) VALUES
(1, 2, 1, 1, 'teste', '2026-06-09 20:50:34', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pessoas`
--

CREATE TABLE `pessoas` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(12) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `documento` varchar(20) NOT NULL,
  `curso` varchar(50) DEFAULT NULL,
  `periodo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pessoas`
--

INSERT INTO `pessoas` (`id`, `nome`, `telefone`, `criado_em`, `documento`, `curso`, `periodo`) VALUES
(1, 'Clodoaldo atualizado', '333333', '2026-06-09 20:43:23', '333333', 'teste', 'teste atualziado');

-- --------------------------------------------------------

--
-- Table structure for table `tipos_atendimentos`
--

CREATE TABLE `tipos_atendimentos` (
  `id` int(11) NOT NULL,
  `tipo_atendimento` enum('agendado','cancelado','concluido','em_andamento','remarcado') DEFAULT 'agendado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipos_atendimentos`
--

INSERT INTO `tipos_atendimentos` (`id`, `tipo_atendimento`) VALUES
(1, 'concluido');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `perfil` enum('admin','aluno','atendente') DEFAULT 'atendente',
  `status` enum('ativo','inativo') DEFAULT 'ativo',
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `perfil`, `status`, `criado_em`) VALUES
(1, 'Administrador', 'admin@atendelab.com', '$2y$10$J9P2kU2BAMZ3TZcuxTsW4e1D/lka8EocYHzvyoOZmCNcWDQz3RuVC', 'admin', 'ativo', '2026-06-02 19:47:00'),
(2, 'JoãoAtualizado', 'joao.atualizar@atendelab.com', '$2y$10$1cFQosY2LKrcrUF2Bb06xeZxF.Td8dNlR/huyD43kKAIAWQsUghXS', 'atendente', 'ativo', '2026-06-09 20:08:42'),
(5, 'TESTE', 'TESE@GMAIL.COM', '$2y$10$q1KE2hlhDAwuKPZ4HZgdcuNt.AS3HSGBbtiaSbeUcmYf3Ssd6j/eK', 'admin', 'ativo', '2026-06-10 00:23:33'),
(7, 'TESTE', 'TESEee@GMAIL.COM', '$2y$10$UvbTaaKOjwMyu7Hp4SzXqeuvrI4zrynZfRSsuptfLSSgm7/3lZXU.', 'aluno', 'ativo', '2026-06-10 00:37:00'),
(8, 'TESTE', 'teste@gmail.com', '$2y$10$VLzcG1ULEO3HOuIDXLuT0uGlUzPiu3NtwDFsK13IcvZQbb9fM8bZe', 'atendente', 'ativo', '2026-06-18 00:19:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `atendimento`
--
ALTER TABLE `atendimento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuario` (`usuario_id`),
  ADD KEY `fk_pessoa` (`pessoa_id`),
  ADD KEY `fk_tipo_atendimento` (`tipo_atendimento_id`);

--
-- Indexes for table `pessoas`
--
ALTER TABLE `pessoas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento` (`documento`),
  ADD UNIQUE KEY `numero` (`telefone`);

--
-- Indexes for table `tipos_atendimentos`
--
ALTER TABLE `tipos_atendimentos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `atendimento`
--
ALTER TABLE `atendimento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pessoas`
--
ALTER TABLE `pessoas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tipos_atendimentos`
--
ALTER TABLE `tipos_atendimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `atendimento`
--
ALTER TABLE `atendimento`
  ADD CONSTRAINT `fk_pessoa` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoas` (`id`),
  ADD CONSTRAINT `fk_tipo_atendimento` FOREIGN KEY (`tipo_atendimento_id`) REFERENCES `tipos_atendimentos` (`id`),
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
