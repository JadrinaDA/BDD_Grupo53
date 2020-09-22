import os 
# PUERTOS id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
def ordename(tupla):
	if tupla[0] == "rut_jefe_cierre":
		return -1
	else:
		return int(tupla[1])
with open("Datos/puertos.csv","r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	informacion_que_quiero = []
	cierre = str()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		informacion_que_quiero.append((tupla[9],tupla[0],tupla[7],tupla[8]))
	informacion_que_quiero.sort(key=ordename)
	for tupla in informacion_que_quiero:
		cierre += (f"{tupla[0]},{tupla[1]},{tupla[2]},{tupla[3]}\n")
with open("Datos/new_cierre.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(cierre)
# with open("Datos/new_cierre.csv","r",encoding="UTF-8") as archivo:
# 	print(archivo.readlines())
