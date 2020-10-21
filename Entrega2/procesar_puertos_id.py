import os 
#id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
#GRUPO 14 pid,nombre_puerto
def soy_tu_id(lista_grupo14,nombre_puerto):
	for tupla_grupo14 in lista_grupo14:
		tupla_grupo14 = tupla_grupo14.strip().split(",")
		if tupla_grupo14[1] == nombre_puerto:
			return tupla_grupo14[0]


def ordename(tupla):
	if tupla[0] != None:
		return int(tupla[0])
	else:
		return -1
with open("Datos/puertos.csv", "r",encoding="UTF-8") as archivo:
	informacion_grupo14 = None
	with open("Datos/puertos_grupo14.csv","r",encoding="UTF-8") as archivo_grupo14:
		informacion_grupo14 = archivo_grupo14.readlines()
	puertos_no_repetidos = set()
	puertos = str()
	informacion = archivo.readlines()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		if tupla[3] == "nombre_puerto":
			pass
		else:
			if tupla[3] != "Valparaiso":
				puertos_no_repetidos.add((soy_tu_id(informacion_grupo14,tupla[3]),tupla[3],tupla[4]))
			else:
				puertos_no_repetidos.add((37,tupla[3],tupla[4]))
	puertos += ("puertos_id,nombre_puerto,ciudad_puerto\n")
	puertos_no_repetidos = list(puertos_no_repetidos)
	puertos_no_repetidos.sort(key=ordename)
	for tupla in puertos_no_repetidos:
		puertos += (f"{tupla[0]},{tupla[1]},{tupla[2]}\n")
with open("Datos/new_puertos_id.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(puertos)
with open("Datos/new_puertos_id.csv","r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	print(informacion)