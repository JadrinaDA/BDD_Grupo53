import os

with open("new_puertos_id.csv","r",encoding="UTF-8") as archivo:
	datos = archivo.readlines()
	informacion_nueva = []
	for tupla in datos:
		tupla = tupla.strip().split(",")
		informacion_nueva.append(tupla[1])
	informacion_vieja = []
	with open("new_puertos.csv","r",encoding="UTF-8") as archivo_2:
		datos_viejos = archivo_2.readlines()
		for tupla_2 in datos_viejos:
			tupla_2 = tupla_2.strip().split(",")
			informacion_vieja.append(tupla_2[0])
	print(f"La dimencion de mi info_nueva es {len(informacion_nueva)}\nLa dimencion de mi informacion_vieja es {len(informacion_vieja)}")
	for tupla in informacion_nueva:
		for tupla_2 in informacion_vieja:
			if tupla == tupla_2:
				print(f"ESTE LO TIENEN AMBOS: {tupla}")