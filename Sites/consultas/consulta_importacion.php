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
  $query_string_buques = "SELECT importacion_usuario_buques()";
  $query_buques = $db_buques -> prepare($query_string_buques);
  $query_buques -> execute();
  $result_buques = $query_buques -> fetchAll();
?>