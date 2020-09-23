<?php
  $user = 'grupo53';
  $password = 'huertitaismybae';
  $databaseName = 'grupo53e2';
  $db = new PDO("pgsql:dbname=$databaseName;host=localhost;port=5432;user=$user;password=$password");

  $query_string = "SELECT * FROM Personal;";
  $query = $db -> prepare($query_string);
  $query -> execute();
  $result = $query -> fetchAll();
?>

<table>
  <tr>
    <th>ID</th>
    <th>Nombre</th>
    <th>Altura</th>
  </tr>
  
  <?php
    foreach ($result as $r) {
      echo "<tr><td>$r[0]</td><</tr>";
    }
  ?>
</table>