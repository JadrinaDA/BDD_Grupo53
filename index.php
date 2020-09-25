<!DOCTYPE html>
<html lang = "en">
<head>
  <meta charset="UTF-8"/>
  <meta name ="viewport" content = "width= device-width, initial-scale= 1.0" />
  <title> Grupo 53: Entrega 2</title>
  <link rel="icon" type="image/png" href="Icono.png">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
  <link rel = "stylesheet" href = "main.css">
  <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Yanone+Kaffeesatz&display=swap" rel="stylesheet">
</head>

<body>
  <h1 align="center">Biblioteca Naviera </h1>
  <p style="text-align:center;">Aquí podrás encontrar información sobre barcos, permisos, puertos y sus instalaciones.</p>

  <br>

  <h3 align="center"> ¿Quieres buscar un puerto por su nombre?</h3>

  <form align="center" action="consultas/consulta_puerto_nombre.php" method="post">
    Nombre:
    <input type="text" name="nombre_puerto">
    <br/><br/>
    <input type="submit" value="Buscar">
  </form>
  
  <br>
  <br>
  <br>
</body>

<?php
  $user = 'grupo53';
  $password = 'huertitaismybae';
  $databaseName = 'grupo53e2';
  $db = new PDO("pgsql:dbname=$databaseName;host=localhost;port=5432;user=$user;password=$password");

  $query_string = "SELECT * FROM Personal;";
  $query = $db -> prepare($query_string);
  $query -> execute();
  $result = $query -> fetchAll();
?>

<table>
  <tr>
    <th>RUT</th>
    <th>Nombre</th>
    <th>Edad</th>
    <th>Sexo</th>
  </tr>
  
  <?php
    foreach ($result as $r) {
      echo "<tr>";
      echo "<td>".$r[0]."</td>";
      echo "<td>".$r[1]."</td>";
      echo "<td>".$r[2]."</td>";
      echo "<td>".$r[3]."</td>";
      echo "</tr>";
    }
  ?>
</table>

</html>