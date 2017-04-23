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
}

?>