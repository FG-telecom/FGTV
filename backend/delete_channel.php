<?php
session_start();
require_once 'config.php';

$id = $_GET['id'];
$stmt = $pdo->prepare("DELETE FROM channels WHERE id = ?");
$stmt->execute([$id]);

header("Location: ../frontend/channels.php");
?>