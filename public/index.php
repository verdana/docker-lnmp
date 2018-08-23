<?php
// Test MySQL connection
$dsn = 'mysql:host=172.100.0.5;port=3306';
$user = 'root';
$password = 'mysql';

try {
    $dbh = new PDO($dsn, $user, $password);
    $version = $dbh->query('SELECT version()')->fetchColumn();
    echo 'MySQL ' . $version . ' connected';
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}

