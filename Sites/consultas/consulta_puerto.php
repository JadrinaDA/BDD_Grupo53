<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://live.staticflickr.com/277/18444588586_10198c34a1_b.jpg" style="width:250px;">
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