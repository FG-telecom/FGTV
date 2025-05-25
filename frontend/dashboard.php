<?php
session_start();
if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit;
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Painel IPTV</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Bem-vindo, <?php echo $_SESSION['user']; ?></h2>
    <ul>
        <li><a href="channels.php">Gerenciar Canais</a></li>
        <li><a href="playlists.php">Gerar Playlist M3U</a></li>
        <li><a href="../backend/logout.php">Sair</a></li>
    </ul>
</body>
</html>