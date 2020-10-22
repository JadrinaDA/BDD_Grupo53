<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://i.imgur.com/d3H5Zih.jpeg" style="width:250px" align="left";>
  <h1> Atraques de un barco en un puerto </h1>
</div>
<body>
  
<?php
  require("../config/conexion.php");

  $query_string_puertos = " SELECT calcular_capacidad('2018-02-20', '2018-06-20');";
  $query_puertos = $db_puertos -> prepare($query_string_puertos);
  $query_puertos -> execute();
  $result_puerto = $query_puertos -> fetchAll();
?>

<table>
    <tr>
      <th>Results</th>
    </tr>
  <?php
  foreach ($result_puerto as $inst) {
      echo "<tr> <td>$inst[0]</td></tr>";
  }
  ?>
  </table>