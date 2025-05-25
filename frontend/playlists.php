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
    <title>Gerar Playlist M3U</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Playlist M3U</h2>
    <a href="../backend/generate_m3u.php">Gerar Playlist M3U</a><br><br>
    <a href="../streams/playlist.m3u" target="_blank">Download da Playlist</a><br><br>
    <a href="dashboard.php">Voltar</a>
</body>
</html>