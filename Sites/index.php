<?php include('header.html');   ?>

<body>
  <h1 align="center">Biblioteca Naviera </h1>
  <p style="text-align:center;">Aquí podrás encontrar información sobre barcos, permisos, puertos y sus instalaciones.</p>

  <br>

  <h3 align="center"> ¿Quieres buscar un puerto por su nombre?</h3>

  <form align="center" action="consultas/consulta_puerto_nombre.php" method="post">
    Nombre:
    <input type="text" name="nombre_puerto">
    <br/><br/>
    <input type="submit" value="Buscar">
  </form>
  
  <br>
  <br>
  <br>

  <h3 align="center">¿Quieres ver todos los puertos y sus ciudades?</h3>

  <form align="center" action="consultas/consulta_puerto.php" method="post">
  <button type="submit" class="btn btn-primary">Buscar</button>
  </form>

</body>

</table>

</html>