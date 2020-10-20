<?php include('../header.html');   ?>

<div class="header_c">
  <img src = "https://i.imgur.com/d3H5Zih.jpeg" style="width:250px" align="left";>
  <h1> Atraques de un barco en un puerto </h1>
</div>
<body>
  
<?php
  require("../config/conexion.php");

  $query_string_puertos = "SELECT importar_usuarios_puertos();";
  $query_puertos = $db_puertos -> prepare($query_string_puertos);
  $query_puertos -> execute();
  $result_puerto = $query_puertos -> fetchAll();
  foreach ($result_puerto as $r){
    $new_r = substr($r[0], 1, -1);
    $user = explode(",", $new_r);
    $user[1] = substr($user[1], 1, -1);
    $query_string_insert = "INSERT INTO usuarios VALUES('$user[0]', '$user[1]',
  '$user[2]', '$user[3]', '$user[4]', '$user[5]', '$user[6]');";
    $query_insert = $db_buques -> prepare($query_string_insert);
    $query_insert -> execute();
  }
  $query_string_buques = "SELECT importar_usuarios_buques();";
  $query_buques = $db_buques -> prepare($query_string_buques);
  $query_buques -> execute();
  $query_strings_usuarios = "SELECT * FROM usuarios;";
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