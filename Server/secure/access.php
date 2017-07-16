<?php
/**
 * Created by PhpStorm.
 * User: JasdipC
 * Date: 2017-04-23
 * Time: 12:13 AM
 */

class access {

    //global db connection variables
    var $host = null;
    var $user = null;
    var $password = null;
    var $dbName = null;
    var $dbConn = null;
    var $result = null;

    /**
     * access constructor.
     * @param null $host
     * @param null $user
     * @param null $password
     * @param null $dbName
     * @param null $dbConn
     * @param null $result
     */
    public function __construct($host, $user, $password, $dbName)
    {
        $this->host = $host;
        $this->user = $user;
        $this->password = $password;
        $this->dbName = $dbName;
    }

    //MARK: Database connection methods
    public function connect() {

        $this->dbConn = mysqli_connect($this->host, $this->user, $this->password, $this->dbName);

        if (mysqli_connect_error()) {
            echo "Could not connect to db </br>";
            echo mysqli_connect_error();
        }

        //support for all languages
        $this->dbConn->set_charset("utf8");
    }
    public function disconnect() {

        if ($this->dbConn != null) {
            $this->dbConn->close();
        }

    }

    //MARK: Registration methods
    public function registerUser($username, $password, $salt, $email, $fullname) {

        $sql = "INSERT INTO Users SET username=?, password=?, salt=?, email=?, fullname=?";
        $statement = $this->dbConn->prepare($sql);

        if (!$statement) {
            throw new Exception($statement->error);
        }

        //binding 5 parameters of type string to sql command
        $statement->bind_param("sssss", $username, $password, $salt, $email, $fullname);

        return $statement->execute();
    }
    public function saveToken($table, $id, $token) {

        $sql = "INSERT INTO $table SET id=?, token=?";
        $statement = $this->dbConn->prepare($sql);

        if (!$statement) {
            throw new Exception($statement->error);
        }

        //bind parameters to sql statement
        $statement->bind_param("is", $id, $token);

        $success = $statement->execute();

        return $success;
    }
    public function updateEmailConfirmationStatus($status, $id) {
        $sql = "UPDATE Users SET emailConfirmation=? WHERE id=?";

        $statement = $this->dbConn->prepare($sql);

        if (!$statement) {
            throw new Exception($statement->error);
        }

        $statement->bind_param("is", $status, $id);

        return $statement->execute();
    }
    public function deleteToken($table, $token) {
        $sql = "DELETE FROM $table WHERE token=?";
        $statement = $this->dbConn->prepare($sql);

        if (!$statement) {
            throw new Exception($statement->error);
        }

        $statement->bind_param("s", $token);

        return $statement->execute();
    }

    //MARK: General database READ methods
    public function getUser($username) {
        $sql = "SELECT * FROM Users WHERE username='".$username."'";
        $result = $this->dbConn->query($sql);

        if ($result != null && (mysqli_num_rows($result) >= 1)) {
            $row = $result->fetch_array(MYSQLI_ASSOC);
        }

        return $row;

    }
    public function getUserID($table, $token) {

        $sql = "SELECT id FROM $table WHERE token = '".$token."'" ;
        $result = $this->dbConn->query($sql);

        $row = array();

        if ($result != null && (mysqli_num_rows($result) >= 1)) {
            $row = $result->fetch_array(MYSQLI_ASSOC);

            if (!empty($row)) {
                return $row;
            }
        }

        return $row;

    }
}

?>
