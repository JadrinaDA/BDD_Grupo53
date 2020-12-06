<html>
<?php include('../templates/header.html');   ?>
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
    #$required = explode(",",$_GET['required']);
    #$forbidden =  explode(",", $_GET['forbidden']);
    $userId =  $_GET['ID'];
    $start = $_GET('start');
    $end = $_GET('start');

    $data = array(
        'desired' => $desired,
        'required' => $required,
        'forbidden' => $forbidden,
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
    $result = file_get_contents( 'http://iic2413-grupo14-53-2020-2.herokuapp.com/text-search', false, $context );
    $response = json_decode($result, true);

    ?>
    <?php echo ' <p> Hola Hola amiguitos </p>'; ?>
    <?php 
        $lat = -33.5;
        $long = 70.5;
        $marker_list = [
            ["lat" -> -33.4,
            "long" -> -70.5],
            ["lat" -> -33.6,
            "long" -> -70.5],
            ["lat" -> -33.5,
            "long" -> -70.6],
                        ];
        foreach ($response as $message) {
            if ($message['date'] >= start && $message['date'] <= end)
            {
                $marker_list.append(["lat" -> $message['lat'], "long" -> $message['long']]);
            }
        }
    ?>
    <div id="mapid" style="height: 180px"> </div>

<?php include('../templates/footer.html'); ?>
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
crossorigin=""></script>
<script> 
var mymap = L.map('mapid').setView([<?php echo $lat ?>, <?php echo $long ?>],10);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
    attribution: '&copy; <a href="https://wwww.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
<?php foreach($marker_list as $marker) {
    echo 
    'L.marker([' . $marker["lat"] . ',' . $marker["long"] . ']).addTo(map);';
    } ?>
></script>
</html>