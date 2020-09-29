<?php include('../header.html');   ?>

<div class="header_c">
  <h1> Atraques de un barco en un puerto </h1>
</div>
<body>
  
<?php
  require("../config/conexion.php");

  $barco = $_POST["nombre_barco"];
  $puerto = $_POST["nombre_puerto"];

  $query_string = "SELECT barcos.nombre,pertenece_a.nombre_puerto FROM barcos,pertenece_a,atraques WHERE barcos.patente=atraques.patente AND atraques.iid=pertenece_a.iid AND pertenece_a.nombre_puerto LIKE '%$puerto%' AND barcos.nombre LIKE '%$barco%';";
  $query = $db -> prepare($query_string);
  $query -> execute();
  $result = $query -> fetchAll();
?>

<table>
  <tr>
    <th>Barco</th>
    <th>Puerto</th>
  </tr>
  
  <?php
    foreach ($result as $r) {
      echo "<tr>";
      echo "<td>".$r[0]."</td>";
      echo "<td>".$r[1]."</td>";
      echo "</tr>";
    }
  ?>