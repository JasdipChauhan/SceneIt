<?php

/**
 * Created by PhpStorm.
 * User: JasdipC
 * Date: 2017-04-30
 * Time: 8:27 PM
 */
class email {

    //generate email token
    function generateToken($length) {

        $characters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890";

        $characterLength = strlen($characters);

        $token = '';

        for ($i = 0; $i < $length; $i++) {
            $token .= $characters[rand(0, $characterLength - 1)];
        }

        return $token;
    }

    function getConfirmationTemplate() {

        $file = fopen("templates/emailConfirmationTemplate.html", "r") or die("Unable to open file");
        $template = fread($file, filesize("templates/emailConfirmationTemplate.html"));

        fclose($file);

        return $template;
    }

    function sendEmail($details) {
        $subject = $details["subject"];
        $to = $details["to"];
        $fromName = $details["fromName"];
        $fromEmail = $details["fromEmail"];
        $body = $details["body"]; //this is the template

        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;content=UTF-8" . "\r\n";
        $headers .= "From: " . $fromName . "<" . $fromEmail . ">" . "\r\n";

        mail($to, $subject, $body, $headers);
    }

}

?>