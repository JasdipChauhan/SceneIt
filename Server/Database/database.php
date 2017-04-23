<?php
/**
 * Created by PhpStorm.
 * User: JasdipC
 * Date: 2017-04-21
 * Time: 7:07 PM
 */

$dbHost = "127.0.0.1";
$dbUser = "root";
$dbPassword = "";
$dbName = "myDB";
$dbTable = "Clients";

$connected = mysqli_connect($dbHost, $dbUser, $dbPassword);
$selected = mysqli_select_db($connected, $dbName);
$success = false;


if ($connected) {

    if ($selected) {
        $success = true;
    } else {
        $success = false;
        return;
    }
} else {
    $success = false;
    return;
}

if ($success) {

    $sql = "SELECT name, city from ".$dbName.".".$dbTable;

    $query = mysqli_query($connected, $sql);


    while ($row = mysqli_fetch_array($query, MYSQLI_ASSOC)) {
        $name = $row["name"];
        $city = $row["city"];

        echo json_encode($row);
    }
} else {
    echo "Failure";
}

?>