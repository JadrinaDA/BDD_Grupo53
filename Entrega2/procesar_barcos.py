import os
# id_instalacion,nombre_barco,patente_barco,pais,fecha_atraque,fecha_salida,descripcion_actividad
def ordename(tupla):
	if tupla[0] == "patente_barco":
		return -1 
	else:
		return len(tupla[1])
with open("Datos/permisos.csv", "r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	informacion_que_quiero = []
	barcos = str()
	for tupla_informacion_completa in informacion:
		tupla_informacion_completa = tupla_informacion_completa.strip().split(",")
		informacion_que_quiero.append((str(tupla_informacion_completa[2]),str(tupla_informacion_completa[1]),str(tupla_informacion_completa[3])))
	informacion_que_quiero_no_repetida = set(informacion_que_quiero)
	informacion_que_quiero_no_repetida = list(informacion_que_quiero_no_repetida)
	informacion_que_quiero_no_repetida.sort(key=ordename)
	for tupla in informacion_que_quiero_no_repetida:
		barcos += (f"{tupla[0]},{tupla[1]},{tupla[2]}\n")
with open("Datos/new_barcos.csv", "w",encoding="UTF-8") as archivo:
	archivo.writelines(barcos)
# with open("Datos/new_barcos.csv","r",encoding="UTF-8") as archivo:
# 	informacion = archivo.readlines()
# 	print(informacion)
 	