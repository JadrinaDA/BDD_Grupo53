import os 
#PERSONAL nombre,rut,edad,sexo,id_instalacion
def ordename(tupla):
	if tupla[0] == "rut":
		return -1
	else:
		return int(tupla[1])
with open("Datos/personal_instalacion.csv","r",encoding="UTF-8") as archivo:
	informacion = archivo.readlines()
	informacion_que_quiero = []
	rut_instalacion = str()
	for tupla in informacion:
		tupla = tupla.strip().split(",")
		informacion_que_quiero.append((tupla[1],tupla[4]))
	informacion_que_quiero.sort(key=ordename)
	for tupla in informacion_que_quiero:
		rut_instalacion += (f"{tupla[0]},{tupla[1]}\n")
with open("Datos/new_trabaja-en.csv","w",encoding="UTF-8") as archivo:
	archivo.writelines(rut_instalacion)
# with open("Datos/new_trabaja-en.csv","r",encoding="UTF-8") as archivo:
# 	print(archivo.readlines())