<?php include('templates/header.html'); ?>
<?php $id_usuario = 13; ?>
        <h1>Aquí hacemos Requests a la API</h1>
        <h3>Ingrese los campos que desea</h3>
        <div class="api-requester">
            <form align="center" action="mapa_mensajes.php" method="get">
                <input type="hidden" name="ID" value="<?php echo $id_usuario ?>">
                <label for="desired">Busqueda Simple:</label><br>
                <input id="desired"> type="text" name="desired">
                <label for="start">Fecha inicio:</label><br>
                <input id="start" type="text" name="start">
                <label for="end">Fecha fin:</label><br>
                <input id="end" type="text" name="end">
            <input type="submit" value="Buscar">
            </form>
        </div>
    </body>
</html>