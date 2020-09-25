<?php include('../header.html');   ?>

<body>
  
<?php
  require("config/conexion.php");
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