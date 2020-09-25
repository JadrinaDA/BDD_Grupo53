<?php include('../header.html');   ?>

<body>
  
<?php
  require("../config/conexion.php");

  $query_string = "SELECT puertos.nombre FROM puertos,pertenece_a,instalaciones WHERE puertos.nombre=pertenece_a.nombre_puerto AND pertenece_a.iid=instalaciones.iid AND instalaciones.tipo='astillero' GROUP BY puertos.nombre HAVING COUNT(instalaciones.tipo)>0;";
  $query = $db -> prepare($query_string);
  $query -> execute();
  $result = $query -> fetchAll();
?>

<table>
  <tr>
    <th>Nombre</th>
  </tr>
  
  <?php
    foreach ($result as $r) {
      echo "<tr>";
      echo "<td>".$r[0]."</td>";
      echo "</tr>";
    }
  ?>