<?php include('../header.html');   ?>

<div class="header_c">
   <img src = "https://i.imgur.com/SdXuEbu.jpeg" style="width:250px" align="left";>
  <h1> Puertos con nombres similares al input </h1>
</div>
<body>

<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");

	$nombre = $_POST["nombre_puerto"];

 	$query = "SELECT * FROM Puertos JOIN Ciudad_Region ON Puertos.ciudad = Ciudad_Region.ciudad WHERE nombre LIKE '%$nombre%';";
	$result = $db -> prepare($query);
	$result -> execute();
	$puertos = $result -> fetchAll();
  ?>

	<table>
    <tr>
      <th>Nombre</th>
      <th>Ciudad</th>
      <th>Region</th>
    </tr>
  <?php
	foreach ($puertos as $puerto) {
  		echo "<tr> <td>$puerto[0]</td> <td>$puerto[1]</td> <td>$puerto[2]</td> </tr>";
	}
  ?>
	</table>