  <?php
  $user_puertos = 'grupo53';
  $user_buques = 'grupo14';
  $password_buques = 'danatas13';
  $password_puertos = 'huertitaismybae';
  $databaseName_puertos = 'grupo53e3';
  $databaseName_buques = 'grupo14e3'
  $db_puertos = new PDO("pgsql:dbname=$databaseName_puertos;host=localhost;port=5432;user=$user_puertos;password=$password_puertos");
 $db_buques = new PDO("pgsql:dbname=$databaseName_buques;host=localhost;port=5432;user=$user_buques;password=$password_buques");
  ?>