import os
#PERMISOS JADRI id_permiso,id_instalacion,patente_barco,nombre_barco,pais,fecha_atraque,descripcion_actividad,fecha_salida
#PERMISOS BASE ENTREEGADA id_instalacion,nombre_barco,patente_barco,pais,fecha_atraque,fecha_salida,descripcion_actividad
def ordename(tupla):
	if tupla[0] == "id_permiso":
		return -1
	else:
		return int(tupla[0])
with open("Datos/new_permisos.csv","r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	informacion_permisos_instalacion = set()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		informacion_permisos_instalacion.add((tupla[0],tupla[1]))
with open("Datos/permisos.csv","r",encoding="UTF-8") as archivo:
	infromacion = archivo.readlines()
	informacion_instalacion_patente = set()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		informacion_instalacion_patente.add((tupla[0],tupla[2]))
conjunto_final = []
for tupla_permiso_instalacion in informacion_permisos_instalacion:
	for tupla_instalacion_patente in informacion_instalacion_patente:
		if tupla_permiso_instalacion[1] == tupla_instalacion_patente[0] or (tupla_permiso_instalacion[0] == "id_permiso" and tupla_instalacion_patente[1] == "patente_barco"):
			conjunto_final.append((tupla_permiso_instalacion[0],tupla_permiso_instalacion[1],tupla_instalacion_patente[1]))
conjunto_final.sort(key=ordename)
atraques = str()
for tupla in conjunto_final:
	atraques += (f"{tupla[0]},{tupla[1]},{tupla[2]}\n")
with open("Datos/new_atraque.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(atraques)
# with open("new_atraque.csv","r",encoding="UTF-8") as archivo:
# 	print(archivo.readlines())


