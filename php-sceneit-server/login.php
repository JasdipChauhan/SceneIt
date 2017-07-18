<?php
/**
 * Created by PhpStorm.
 * User: JasdipC
 * Date: 2017-05-01
 * Time: 11:22 AM
 */

//declare variables
$username = htmlentities($_REQUEST["username"]);
$password = htmlentities($_REQUEST["password"]);

if (empty($username) || empty($password)) {
    $returnArray["status"] = "400";
    $returnArray["message"] = "Missing required information";
    echo json_encode($returnArray);
    return;
}

//2) Build the connection with MySQL database
require ("secure/access.php");
$file = parse_ini_file("SceneIt.ini");

$dbHost = "";
$dbUser = "";
$dbPass = "";
$dbName = "";

if (!empty($file)) {
    $dbHost = $file["dbHost"];
    $dbUser = $file["dbUser"];
    $dbPass = $file["dbPassword"];
    $dbName = $file["dbName"];
} else {
    echo "ini config file is empty";
}

$access = new access($dbHost, $dbUser, $dbPass, $dbName);
$access->connect();

//3) Get the users information from db
$user = $access->getUser($username);

if (empty($user)) {
    $returnArray["status"] = "403";
    $returnArray["message"] = "User is not found";

    echo json_encode($returnArray);
    return;
}

//4) Get password and salt password
$securedPassword = $user["password"];
$salt = $user["salt"];

if ($securedPassword == sha1($password . $salt)) {
    $returnArray["status"] = "200";
    $returnArray["message"] = "Logged in successfully";
    $returnArray["id"] = $user["id"];
    $returnArray["username"] = $user["username"];
    $returnArray["email"] = $user["email"];
    $returnArray["fullname"] = $user["fullname"];
    $returnArray["ava"] = $user["ava"];
} else {
    $returnArray["status"] = "403";
    $returnArray["message"] = "Invalid password";
}

$access->disconnect();

echo json_encode($returnArray);


?>