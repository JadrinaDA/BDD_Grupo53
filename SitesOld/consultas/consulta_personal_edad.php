<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://i.imgur.com/Bxaw8A0.jpeg" style="width:250px" align="left";>
  <h1> Edad promedio de trabajadores de un puerto </h1>
</div>
<body>
  
<?php
  require("../config/conexion.php");

  $query_string = "SELECT puertos.nombre,AVG(personal.edad) as Edad_Promedio_Por_Puerto FROM personal,trabaja_en,pertenece_a, puertos WHERE personal.rut=trabaja_en.rut AND trabaja_en.iid=pertenece_a.iid AND pertenece_a.nombre_puerto=puertos.nombre GROUP BY puertos.nombre;";
  $query = $db -> prepare($query_string);
  $query -> execute();
  $result = $query -> fetchAll();
?>

<table>
  <tr>
    <th>Puerto</th>
    <th>Edad Promedio</th>
  </tr>
  
  <?php
    foreach ($result as $r) {
      echo "<tr>";
      echo "<td>".$r[0]."</td>";
      echo "<td>".$r[1]."</td>";
      echo "</tr>";
    }
  ?>