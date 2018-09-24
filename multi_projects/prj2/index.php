<html>
  <body>
    <h1>B PHP</h1>

    <?php echo "PHP Works!";    ?>
    <?php $mysqli = new mysqli("mariadb", "drupal", "drupal", "drupal");
    echo $mysqli->server_info;
    ?>
  </body>
</html>
