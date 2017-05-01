<?php
/**
 * Created by PhpStorm.
 * User: JasdipC
 * Date: 2017-04-30
 * Time: 8:19 PM
 */

//Step 1: Get token
$token = htmlentities($_GET["token"]);

if (empty($token)) {
    echo json_encode("Missing token");
}

//Step 2: DB Connection
$file = parse_ini_file("../SceneIt.ini");

if (!empty($file)) {
    $host = $file["dbHost"];
    $user = $file["dbUser"];
    $pass = $file["dbPassword"];
    $name = $file["dbName"];
} else {
    echo "ini config file is empty";
}

require ("../secure/access.php");
$dbAccess = new access($host, $user, $pass, $name);
$dbAccess -> connect();

//Step 3: get id of user
$userRow = $dbAccess -> getUserID("emailTokens", $token);
$id = $userRow["id"];

if (empty($id)) {
    echo "User with this token does not exist";
    return;
}

//Step 4: change email confirmation status & delete the email token
$result = $dbAccess->updateEmailConfirmationStatus(1, $id);

if ($result) {
    $dbAccess->deleteToken("emailTokens", $token);
    echo "Thank you, your email is now confirmed";
}


//Step 5: close db connection
$dbAccess->disconnect();

?>