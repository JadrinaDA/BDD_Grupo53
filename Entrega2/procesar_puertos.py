import os 
#id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
with open("Datos/puertos.csv", "r",encoding="UTF-8") as archivo:
	puertos_no_repetidos = set()
	puertos = str()
	informacion = archivo.readlines()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		if tupla[3] == "nombre_puerto":
			pass
		else:
			puertos_no_repetidos.add((tupla[3],tupla[4]))
	puertos += ("nombre_puerto,ciudad_puerto\n")
	for tupla in puertos_no_repetidos:
		puertos += (f"{tupla[0]},{tupla[1]}\n")
with open("Datos/new_puertos.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(puertos)
# with open("Datos/new_puertos.csv","r",encoding="UTF-8") as archivo:
# 	informacion = archivo.readlines()
# 	print(informacion)