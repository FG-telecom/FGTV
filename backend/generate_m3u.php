<?php
require_once 'config.php';

$file = fopen("../streams/playlist.m3u", "w");
fwrite($file, "#EXTM3U\n");

$stmt = $pdo->query("SELECT * FROM channels");
while ($row = $stmt->fetch()) {
    fwrite($file, "#EXTINF:-1 group-title=\"" . $row['group_title'] . "\"," . $row['name'] . "\n");
    fwrite($file, $row['url'] . "\n");
}

fclose($file);
header("Location: ../frontend/playlists.php");
?>