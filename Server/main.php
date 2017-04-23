<?php


$post1 = $_POST['post1'];
echo $post1;

$post2 = $_POST['post2'];
echo $post2;


?>


<html>
<body>

<form action="main.php" method="post">
    Username: <input type="text" name="post1"><br>
    Password: <input type="text" name="post2"><br>
    <input type="submit">
</form>

</body>
</html>
