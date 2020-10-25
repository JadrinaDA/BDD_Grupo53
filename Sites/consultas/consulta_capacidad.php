<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://i.imgur.com/d3H5Zih.jpeg" style="width:250px" align="left";>
  <h1> Atraques de un barco en un puerto </h1>
</div>
<body>
  
<?php
  require("../config/conexion.php");

  $tipo = $_POST["tipo"];
  $start = $_POST["start"];
  $end = $_POST["end"];
  $patente = $_POST["patente"];

  $query_string_all = "SELECT print_available('$tipo', '$start', '$end');";
  $query_all= $db_puertos -> prepare($query_string_all);
  $query_all -> execute();
  $result_puerto = $query_all -> fetchAll();
?>

<table>
    <tr>
      <th>ID</th>
      <th>Tipo</th>
      <th>Capacidad</th>
    </tr>
  <?php
  foreach ($result_puerto as $r) {
      $new_r = substr($r[0], 1, -1);
      $inst = explode(",", $new_r);
      echo "<tr> <td>$inst[0]</td><td>$inst[1]</td><td>$inst[2]</td></tr>";
  }
  ?>
  </table>