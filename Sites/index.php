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

  <h3 align="center"> ¿Quieres buscar a los jefes de un puerto?</h3>

  <form align="center" action="consultas/consulta_personal.php" method="post">
    Nombre Puerto:
    <input type="text" name="nombre_puerto">
    <br/><br/>
    <input type="submit" value="Buscar">
  </form>

  <br>
  <br>
  <br>

  <h3 align="center"> ¿Quieres buscar a las veces que un barco a atracado en un puerto?</h3>

  <form align="center" action="consultas/consulta_atraque.php" method="post">
    Nombre Puerto:
    <input type="text" name="nombre_puerto">
    <br/>
    Nombre Barco:
    <input type="text" name="nombre_barco">
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

  <br>
  <br>
  <br>

  <h3 align="center">¿Quieres ver todos los puertos con al menos un astillero?</h3>

  <form align="center" action="consultas/consulta_puerto_astillero.php" method="post">
  <button type="submit" class="btn btn-primary">Buscar</button>
  </form>

  <br>
  <br>
  <br>

  <h3 align="center">¿Quieres ver la edad promedio de los trabajadores de los puertos?</h3>

  <form align="center" action="consultas/consulta_personal_edad.php" method="post">
  <button type="submit" class="btn btn-primary">Buscar</button>
  </form>

</body>

</table>

</html>