<html>
<head>
	<title> Mapa Yolo </title>
	<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
   integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
   crossorigin=""/>
</head>
<body>
	<?php echo ' <p> Hola Hola amiguitos </p>'; ?>
	<?php 
		$lat = -33.5;
		$long = -70.5;
		$marker_list = [
			["lat" => -33.34178791413483,
			"long" => -70.4970481453545],
			["lat" => -33.45111638164483,
			"long" => -70.57843021139097],
			["lat" => -33.47080231320502
			"long" => -70.7349945942062],
			["lat" => -33.38932342343817, rglñmergñ
			"long" => -70.50206593206686],
			 			];
	?>
	<div id="mapid" style="height: 500px"> </div>
</body>
<!-- Make sure you put this AFTER Leaflet's CSS -->
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