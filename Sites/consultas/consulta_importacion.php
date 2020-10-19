<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://i.imgur.com/d3H5Zih.jpeg" style="width:250px" align="left";>
  <h1> Atraques de un barco en un puerto </h1>
</div>
<body>
  
<?php
  require("../config/conexion.php");

  $query_string_puertos = "SELECT importacion_usuario_puertos()";
  $query_puertos = $db_puertos -> prepare($query_string_puertos);
  $query_puertos -> execute();
  $result_puerto = $query_puertos -> fetchAll();
  $query_string_insert = "INSERT INTO Usuarios VALUES ($result_puerto[0], $result_puerto[1].
  result_puerto[2], $result_puerto[3], result_puerto[4], $result_puerto[5], $result_puerto[6])";
  foreach ($result_puerto as  $user){
    $query_string_insert -> execute();
  }
  $query_string_buques = "SELECT importacion_usuario_buques()";
  $query_buques = $db_buques -> prepare($query_string_buques);
  $query_buques -> execute();
  $query_strings_usuarios = "SELECT * FROM usuarios";
  $query_usuarios = $db_buques -> prepare($query_strings_usuarios);
  $query_usuarios -> execute();
  $result_usuarios = $query_usuarios -> fetchAll();
?>

<table>
    <tr>
      <th>ID</th>
      <th>Nombre</th>
      <th>Edad</th>
      <th>Sexo</th>
      <th>Pasaporte</th>
      <th>Nacionalidad</th>
      <th>Password</th>
    </tr>
  <?php
  foreach ($result_usuarios as $usuario) {
      echo "<tr> <td>$usuario[0]</td> <td>$usuario[1]</td> <td>$usuario[2]</td> <td>$usuario[3]</td> <td>$usuario[4]</td> <td>$usuario[5]</td> <td>$usuario[6]</td></tr>";
  }
  ?>
  </table>