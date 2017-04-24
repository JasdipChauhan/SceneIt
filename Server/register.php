<?php

require ("secure/access.php");

//1) declare parameters of user information
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

//2) Build the connection with MySQL database
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

//3) Add user information
$result = $access->registerUser($username, $secured_password, $salt, $email, $fullname);

if ($result) {

    $user = $access->selectUser($username);

    $arrayStatus["status"] = "200";
    $arrayStatus["message"] = "Successfully registered";
    $arrayStatus["id"] = $user["id"];
    $arrayStatus["username"] = $user["username"];
    $arrayStatus["email"] = $user["email"];
    $arrayStatus["fullname"] = $user["fullname"];
    $arrayStatus["ava"] = $user["ava"];

} else {
    $arrayStatus["status"] = "400";
    $arrayStatus["message"] = "Could not register with the provided information";
}

$access->disconnect();

echo json_encode($arrayStatus);

?>