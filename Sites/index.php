<?php include('templates/header.html'); ?>
<?php $id_usuario = 13; ?>
        <h1>Aquí hacemos Requests a la API</h1>
        <h3>Ingrese los campos que desea</h3>
        <div class="api-requester">
            <form align="center" action="mapa_mensajes.php" method="get">
                <label for="ID">ID Usuario:</label><br>
                <input id="ID" type="int" name="ID">
                <label for="desired">Busqueda Simple:</label><br>
                <input id="desired" type="text" name="desired">
                <label for="start">Fecha inicio:</label><br>
                <input id="start" type="date" name="start">
                <label for="end">Fecha fin:</label><br>
                <input id="end" type="date" name="end">
            <input type="submit" value="Buscar">
            </form>
        </div>
    </body>
</html>