<?php

try {
require __DIR__ . '/vendor/autoload.php';

//librería para poder leer archivos.env
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

try {
    $pdo = new \PDO($_ENV['DB_CONNECTION'] . ":host=" . 
        $_ENV['DB_HOST'].";port=".$_ENV['DB_PORT'] . ";dbname=" . $_ENV['DB_DATABASE'], 
        $_ENV['DB_USERNAME'], $_ENV['DB_PASSWORD']);
    $pdo->exec("set names utf8");
    $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Exception PDO";
    echo $e->getMessage();
    exit();
}

// $sql = "SELECT * FROM personas WHERE id = :id";
$sql = "SELECT * FROM personas";

$params = [
    ":id" => 2
];

$ps = $pdo->prepare($sql);
$ps->execute($params);
$result = $ps->columnCount()>0? $ps->fetchAll(\PDO::FETCH_ASSOC): $ps->rowCount(); 

echo '<h1 class="c-titulo">Resultado</h1>';

foreach ($result as $key => $value) {
    foreach ($value as $ky => $val) {
        echo $ky . ": " . $val . " ";
    }
    echo "<br>";
}



} catch (Exception $e) {
    echo "Exception";
    echo $e->getMessage();
}
