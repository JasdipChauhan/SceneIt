<?php

require ("secure/access.php");

//declare parameters of user information
$username = htmlentities($_REQUEST["username"]);
$password = htmlentities($_REQUEST["password"]);
$email = htmlentities($_REQUEST["email"]);
$fullname = htmlentities($_REQUEST["fullname"]);

if (empty($username) || empty($password) || empty($email) || empty($fullname)) {

    $arrayStatus["status"] = "400";
    $arrayStatus["message"] = "Missing required information";
    echo json_encode($arrayStatus);
    return;
}

//secure password
$salt = openssl_random_pseudo_bytes(20);
$secured_password = sha1($password.$salt);


$file = parse_ini_file("SceneIt.ini");

if (!empty($file)) {
    $host = $file["dbHost"];
    $user = $file["dbUser"];
    $pass = $file["dbPassword"];
    $name = $file["dbName"];
} else {
    echo "ini config file is empty";
}

$access = new access($host, $user, $pass, $name);
$access->connect();


?>