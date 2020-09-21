import os
# id_instalacion,nombre_barco,patente_barco,pais,fecha_atraque,fecha_salida,descripcion_actividad
with open("Datos/permisos.csv", "r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	barcos = str()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		barcos += (f"{tupla[2]},{tupla[1]},{tupla[3]}\n")
with open("Datos/new_barcos.csv", "w",encoding="UTF-8") as archivo:
	archivo.writelines(barcos)
# with open("Datos/new_barcos.csv","r",encoding="UTF-8") as archivo:
# 	informacion = archivo.readlines()
# 	print(informacion)
# 	