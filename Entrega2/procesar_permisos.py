import os
#PERMISOS JADRI id_permiso,id_instalacion,patente_barco,nombre_barco,pais,fecha_atraque,descripcion_actividad,fecha_salida
with open("Datos/new_permisos.csv","r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	informacion_que_quiero = []
	permisos = str()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		informacion_que_quiero.append((tupla[0],tupla[5]))
	for tupla in informacion_que_quiero:
		permisos += (f"{tupla[0]},{tupla[1]}\n")
with open("Datos/new_permisos-2.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(permisos)
with open("Datos/new_permisos-2.csv","r",encoding="UTF-8") as archivo:
	print(archivo.readlines())