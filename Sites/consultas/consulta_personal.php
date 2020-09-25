<?php include('../header.html');   ?>

<body>
  
<?php
  require("config/conexion.php");

  $nombre = $_POST["nombre_puerto"];

  $query_string = "SELECT personal.nombre FROM personal,jefes,trabaja_en,pertenece_a WHERE personal.rut=jefes.rut AND personal.rut=trabaja_en.rut AND trabaja_en.iid=pertenece_a.iid AND pertenece_a.nombre_puerto LIKE nombre;";
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