import os
# id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
def ordename(tupla):
	if tupla[0] == "id_instalacion":
		return -1 
	else:
		return int(tupla[0])
with open("Datos/puertos.csv", "r",encoding="UTF-8") as archivo:
	instalaciones = str()
	informacion = archivo.readlines()
	informacion_que_quiero = []
	for tupla_informacion_completa in informacion:
		tupla_informacion_completa = tupla_informacion_completa.strip().split(",")
		informacion_que_quiero.append((tupla_informacion_completa[0],tupla_informacion_completa[1],tupla_informacion_completa[2]))
	informacion_que_quiero_no_repetida = set(informacion_que_quiero)
	informacion_que_quiero_no_repetida = list(informacion_que_quiero_no_repetida)
	informacion_que_quiero_no_repetida.sort(key=ordename)
	for tupla in informacion_que_quiero_no_repetida:
		instalaciones += (f"{tupla[0]},{tupla[1]},{tupla[2]}\n")
with open("Datos/new_instalaciones.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(instalaciones)
# with open("Datos/new_instalaciones.csv","r") as archivo:
# 	informacion = archivo.readlines()
# 	print(informacion)

	