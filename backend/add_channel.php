<?php
session_start();
require_once 'config.php';

$name = $_POST['name'];
$url = $_POST['url'];
$group = $_POST['group'];

$stmt = $pdo->prepare("INSERT INTO channels (name, url, group_title) VALUES (?, ?, ?)");
$stmt->execute([$name, $url, $group]);

header("Location: ../frontend/channels.php");
?>