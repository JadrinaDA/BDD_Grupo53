import os 
#id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
with open("Datos/puertos.csv", "r",encoding="UTF-8") as archivo:
	ciudades_no_repetidos = set()
	ciudades = str()
	informacion = archivo.readlines()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		if tupla[3] == "nombre_puerto":
			pass
		else:
			ciudades_no_repetidos.add((tupla[4],tupla[5]))
	ciudades += ("ciudad_puerto,region_puerto\n")
	for tupla in ciudades_no_repetidos:
		ciudades += (f"{tupla[0]},{tupla[1]}\n")
with open("Datos/new_ciudades-region.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(ciudades)
# with open("Datos/new_ciudades-region.csv","r",encoding="UTF-8") as archivo:
# 	informacion = archivo.readlines()
# 	print(informacion)