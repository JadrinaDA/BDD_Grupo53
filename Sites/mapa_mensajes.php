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
    echo $start;
    echo $end;
    $data = array(
        'desired' => $desired,
        'userId' => intval($userId)
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
    <?php echo ' <p> Hola Hola amiguitos </p>'; ?>
    <?php 
        $lat = -33.5;
        $long = 70.5;
        $marker_list = [
            ["lat"  => -33.4,
            "long"  => -70.5],
            ["lat"  => -33.6,
            "long"  => -70.5],
            ["lat"  => -33.5,
            "long"  => -70.6],
                        ];
        foreach ($response as $message) {
            echo $message['message'];
            if (date($message['date']) >= $start && date($message['date']) <= $end)
            {
                 $marker_list = array_merge($marker_list, [["lat" => $message['lat'], "long" => $message['long']]]);
             }
        }

// ACA LAS CONSULTAS RESPECTO A SI ES JEFE/CAPITAN Y SUS MARKERS.
    require("../config/conexion.php");
    $new_id = $userId - 1;
    $query_jefe = "SELECT usuarios.pasaporte FROM usuarios WHERE usuarios.uid = $new_id;";
    $result = $db_buques -> prepare($query_jefe);
    $result -> execute();
    $rut = $result -> fetchAll();

    $query_str_coords = "SELECT markers_jefe('$rut');";
    $query_coords = $db_puertos -> prepare($query_str_coords);
    $query_coords ->execute();
    $coords  = $query_coords -> fetchAll();

    if $coords != 'None'
    {
        $latlong = explode(",", $coords);
        $lat = $latlong[0];
        $long = $latlong[1];
        $marker_list = array_merge($marker_list, [["lat" => $lat, "long" => $long]]);
    }


    ?>
    <div id="mapid" style="height: 500px"> </div>
</body>
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
crossorigin=""></script>
<script> 
var map = L.map('mapid').setView([<?php echo $lat ?>, <?php echo $long ?>],10);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
    attribution: '&copy; <a href="https://wwww.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
<?php foreach($marker_list as $marker) {
    echo 
    'L.marker([' . $marker["lat"] . ',' . $marker["long"] . ']).addTo(map);';
    } ?>
</script>
</html>