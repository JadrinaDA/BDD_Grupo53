import os
#PERMISOS JADRI id_permiso,id_instalacion,patente_barco,nombre_barco,pais,fecha_atraque,descripcion_actividad,fecha_salida
def limpiame(lista):
	informacion = []
	for tupla in lista:
		if str(tupla[1]) != "":
			informacion.append(tupla)
	return informacion
with open("Datos/new_permisos.csv","r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	informacion_que_quiero = []
	astillero = str()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		informacion_que_quiero.append((tupla[0],tupla[7]))
	informacion_que_quiero = limpiame(informacion_que_quiero)
	for tupla in informacion_que_quiero:
		astillero += (f"{tupla[0]},{tupla[1]}\n")
with open("Datos/new_permisos-astillero.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(astillero)
with open("Datos/new_permisos-astillero.csv","r",encoding="UTF-8") as archivo:
	print(archivo.readlines())