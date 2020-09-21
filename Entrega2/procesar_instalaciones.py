import os
# id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
with open("Datos/puertos.csv", "r",encoding="UTF-8") as archivo:
	instalaciones = str()
	informacion = archivo.readlines()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		instalaciones += (f"{tupla[0]},{tupla[1]},{tupla[2]}\n")
with open("Datos/new_instalaciones.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(instalaciones)
# with open("Datos/new_instalaciones.csv","r") as archivo:
# 	informacion = archivo.readlines()
# 	print(informacion)
	