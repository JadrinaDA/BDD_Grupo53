import os
# PUERTOS id_instalacion,tipo_instalacion,capacidad_instalacion,nombre_puerto,ciudad_puerto,region_puerto,rut_jefe,fecha_cierre,fecha_apertura,rut_jefe_cierre
def ordename(tupla):
	if tupla[0] == "rut_jefe":
		return -1
	else:
		return int(tupla[1])
with open("Datos/puertos.csv", "r",encoding="UTF-8") as archivo:
	infromacion = archivo.readlines()
	infromacion_que_quiero = []
	rut_jefes = str()
	for tupla_informacion_completa in infromacion:
		tupla_informacion_completa = tupla_informacion_completa.strip().split(",")
		infromacion_que_quiero.append((tupla_informacion_completa[6],tupla_informacion_completa[0]))
	infromacion_que_quiero_ordenar = set(infromacion_que_quiero)
	infromacion_que_quiero_ordenar = list(infromacion_que_quiero_ordenar)
	infromacion_que_quiero_ordenar.sort(key=ordename)
	for tupla in infromacion_que_quiero_ordenar:
		rut_jefes += (f"{tupla[0]},{tupla[1]}\n")
with open("Datos/new_jefes.csv","w", encoding="UTF-8") as archivo:
	archivo.writelines(rut_jefes)
# with open("Datos/new_jefes.csv", "r", encoding="UTF-8") as archivo:
# 	infromacion = archivo.readlines()
# 	print(infromacion)
