<?php
session_start();
if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit;
}
require_once '../backend/config.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Gerenciar Canais</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Canais</h2>
    <form method="POST" action="../backend/add_channel.php">
        <input type="text" name="name" placeholder="Nome do Canal" required>
        <input type="text" name="url" placeholder="URL do Stream" required>
        <input type="text" name="group" placeholder="Grupo (ex: Abertos)">
        <button type="submit">Adicionar</button>
    </form>

    <h3>Lista de Canais</h3>
    <table border="1">
        <tr><th>Nome</th><th>URL</th><th>Grupo</th><th>Ação</th></tr>
        <?php
        $stmt = $pdo->query("SELECT * FROM channels");
        while ($row = $stmt->fetch()) {
            echo "<tr>
                <td>{$row['name']}</td>
                <td>{$row['url']}</td>
                <td>{$row['group_title']}</td>
                <td><a href='../backend/delete_channel.php?id={$row['id']}'>Excluir</a></td>
            </tr>";
        }
        ?>
    </table>

    <a href="dashboard.php">Voltar</a>
</body>
</html>