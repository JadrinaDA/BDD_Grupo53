<?php
  try {
    #Pide las variables para conectarse a la base de datos.
    require('data.php'); 
    # Se crea la instancia de PDO

  $db_puertos = new PDO("pgsql:dbname=$databaseName_puertos;host=localhost;port=5432;user=$user_puertos;password=$password_puertos");
  $db_buques = new PDO("pgsql:dbname=$databaseName_buques;host=localhost;port=5432;user=$user_buques;password=$password_buques");

  $db_connection_puertos = pg_connect("host=localhost port=5432 dbname=$databaseName_puertos user=$user_puertos password=$password_puertos");
  $db_connection_buques = pg_connect("host=localhost port=5432 dbname=$databaseName_buques user=$user_buques password=$password_buques");
  
    // $db = new PDO("pgsql:dbname=$databaseName;host=localhost;port=5432;user=$user;password=$password");
  } catch (Exception $e) {
    echo "No se pudo conectar a la base de datos: $e";
  }
?>
