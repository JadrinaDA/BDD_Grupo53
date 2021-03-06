<html>
<head>
    <title> Mapa Yolo </title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
   integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
   crossorigin=""/>
</head>

<body>
    <?php 
    # Aquí deberían manejar los casos en los que no se ingrese información en alguno de los inputs del form, por simplicidad  
    $desired = explode(",", $_GET['desired']);
    $userId =  $_GET['ID'];
    $start = date($_GET['start']);
    $end = date($_GET['end']);
    $data = array(
        'desired' => $desired,
    );


    $options = array(
        'http' => array(
        'method'  => 'GET',
        'content' => json_encode( $data ),
        'header'=>  "Content-Type: application/json\r\n" .
                    "Accept: application/json\r\n"
        )
    );
    
    $context  = stream_context_create( $options );
    $result = file_get_contents( 'https://iic2413-grupo14-53-2020-2.herokuapp.com/text-search', false, $context);
    $response = json_decode($result, true);
    ?>
    <?php 
        $lat_focus = -33.32;
        $long_focus = -70.32;
        $marker_jefes = [];
        $marker_mensajes = [];
        $marker_puertos = [];
        foreach ($response as $message) {
            if (($message['sender'] == intval($userId) || $message['receptant'] == intval($userId)) && date($message['date']) >= $start && date($message['date']) <= $end)
            {   
                 $marker_mensajes = array_merge($marker_mensajes, [["lat" => $message['lat'], "long" => $message['long']]]);
             }
        }

// ACA LAS CONSULTAS RESPECTO A SI ES JEFE/CAPITAN Y SUS MARKERS.
    require("config/conexion.php");
    $new_id = $userId - 1;
    $query_jefe = "SELECT usuarios.pasaporte FROM usuarios WHERE usuarios.uid = $new_id;";
    $result = $db_buques -> prepare($query_jefe);
    $result -> execute();
    $rut_array = $result -> fetchAll();
    $rut = $rut_array[0][0];

    $query_str_coords = "SELECT * FROM markers_jefe('$rut');";
    $query_coords = $db_puertos -> prepare($query_str_coords);
    $query_coords ->execute();
    $coords  = $query_coords -> fetchAll();
    if ($coords[0][0] != 'None')
    {
        $latlong = explode(",", $coords[0][0]);
        $lat = $latlong[0];
        $long = $latlong[1];
        $marker_jefes = array_merge($marker_jefes, [["lat" => $lat, "long" => $long]]);
    }

    $query_str_nombres = "SELECT * FROM puertos_capitan('$new_id');";
    $query_noms = $db_buques -> prepare($query_str_nombres);
    $query_noms ->execute();
    $noms  = $query_noms -> fetchAll();
    
    foreach ($noms as $nombre) {
        echo $nombre[0];
        $nom = $nombre[0];
        $query_str_coords2 = "SELECT latitud, longitud FROM puerto_coords WHERE puerto = '$nom'";
        $query_coords2 = $db_puertos -> prepare($query_str_coords2);
        $query_coords2 -> execute();
        $coords2 = $query_coords2 -> fetchAll();
        $marker_puertos = array_merge($marker_puertos, [["lat" => $coords2[0][0], "long" => $coords2[0][1]]]);
    }



    ?>
    <div id="mapid" style="height: 500px"> </div>
</body>
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
crossorigin=""></script>
<script> 
var map = L.map('mapid').setView([<?php echo $lat_focus ?>, <?php echo $long_focus ?>],10);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
    attribution: '&copy; <a href="https://wwww.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
var greenIcon = new L.Icon({
iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
iconSize: [25, 41],
iconAnchor: [12, 41],
popupAnchor: [1, -34],
});
var blueIcon = new L.Icon({
iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
iconSize: [25, 41],
iconAnchor: [12, 41],
popupAnchor: [1, -34],
});
var redIcon = new L.Icon({
iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
iconSize: [25, 41],
iconAnchor: [12, 41],
popupAnchor: [1, -34],
});
<?php foreach($marker_jefes as $marker) {
    echo 
    'L.marker([' . $marker["lat"] . ',' . $marker["long"] . ']' . ',' . '{icon: greenIcon}).addTo(map);';
    } 
    foreach($marker_mensajes as $marker) {
    echo 
    'L.marker([' . $marker["lat"] . ',' . $marker["long"] . ']' . ',' . '{icon: blueIcon}).addTo(map);';
    }
    foreach($marker_puertos as $marker) {
    echo 
    'L.marker([' . $marker["lat"] . ',' . $marker["long"] . ']' . ',' . '{icon: redIcon}).addTo(map);';
    }
    ?>
</script>
</html>