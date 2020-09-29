<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://i.imgur.com/d3H5Zih.jpeg" style="width:250px" align="left";>
  <h1> Todos los puertos y sus ciudades </h1>
</div>

<body>

<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");

 	$query = "SELECT * FROM Puertos";
	$result = $db -> prepare($query);
	$result -> execute();
	$puertos = $result -> fetchAll();
  ?>

	<table>
    <tr>
      <th>Nombre</th>
      <th>Ciudad</th>
    </tr>
  <?php
	foreach ($puertos as $puerto) {
  		echo "<tr> <td>$puerto[0]</td> <td>$puerto[1]</td></tr>";
	}
  ?>
	</table>