<?php include('../header.html');   ?>

<body>

<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");

	$mes = $_POST["mes"];
  $mes = strtolower($mes);
  $year = $_POST["year"];

  $meses = array("enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"); 
  for($n = 0; $n < 12; $n++){ 
   if ($mes == $meses[$n]){
      $mes = strval($n + 1);
    }
  } 
  if (is_numeric($mes)){
    if (intval($mes) < 10){
      $mes = '0'.$mes;
      } 
  }

  echo "'$year-$mes-01";


 	$query = "SELECT puertos.nombre FROM puertos,pertenece_a,atraques,permisos WHERE puertos.nombre=pertenece_a.nombre_puerto AND pertenece_a.iid=atraques.iid AND atraques.pid=permisos.pid AND permisos.fecha_atraque>'$year-$mes-01' AND permisos.fecha_atraque<'$year-$mes-31' GROUP BY puertos.nombre HAVING COUNT(puertos.ciudad)> ANY (SELECT COUNT(p.ciudad) FROM puertos AS p,pertenece_a AS pa,atraques AS a,permisos AS pe WHERE p.nombre=pa.nombre_puerto AND pa.iid=a.iid AND a.pid=pe.pid AND pe.fecha_atraque>'$year-$mes-01' AND pe.fecha_atraque<'$year-$mes-31' GROUP BY p.nombre);";
	$result = $db -> prepare($query);
	$result -> execute();
	$puertos = $result -> fetchAll();
  ?>

	<table>
    <tr>
      <th>Nombre Puerto</th>
    </tr>
  <?php
	foreach ($puertos as $puerto) {
  		echo "<tr> <td>$puerto[0]</td>";
	}
  ?>
	</table>