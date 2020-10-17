<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://i.imgur.com/d3H5Zih.jpeg" style="width:250px" align="left";>
  <h1> Atraques de un barco en un puerto </h1>
</div>
<body>
  
<?php
  require("../config/conexion.php");

  $query_string = "SELECT * FROM navieras";
  $query = $db_buques -> prepare($query_string);
  $query -> execute();
  $result = $query -> fetchAll();
?>

<table>
  <tr>
    <th>ID</th>
    <th>Nombre</th>
    <th>ID País</th>
    <th>Giro</th>
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