import os 
# PUERTOS id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
def ordename(tupla):
	if tupla[0] == "id_instalacion":
		return -1
	else:
		return int(tupla[0])
with open("Datos/puertos.csv","r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	informacion_que_quiero = []
	pertenece = str()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		informacion_que_quiero.append((tupla[0],tupla[3],tupla[4]))
	informacion_que_quiero = set(informacion_que_quiero)
	informacion_que_quiero = list(informacion_que_quiero)
	informacion_que_quiero.sort(key=ordename)
	for tupla in informacion_que_quiero:
		pertenece += (f"{tupla[0]},{tupla[1]},{tupla[2]}\n")
with open("Datos/new_pertecene-a.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(pertenece)
# with open("Datos/new_pertecene-a.csv","r",encoding="UTF-8") as archivo:
# 	print(archivo.readlines())
