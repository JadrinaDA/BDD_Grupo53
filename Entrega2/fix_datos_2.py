import os

with open("Datos/permisos.csv", "r") as archivo:
	info = archivo.readlines()
	new_info = []
	counter = "id_permiso"
	for line in info:
		line = line.strip().split(",")
		new_line = [str(counter), line[0], line[2], line[1], line[3], line[4], line[6], line[5]]
		new_info.append(new_line)
		if type(counter) == str:
			counter = 1
		else:
			counter += 1

with open("Datos/new_permisos.csv", "w") as new_archivo:
	new_lines = []
	for line in new_info:
		new_string = (line[0] + "," + line[1] + "," + line[2] + "," + line[3] + "," + line[4]
		 + "," + line[5] + "," + line[6] + "," + line[7] + "\n")
		new_lines.append(new_string)
	new_archivo.writelines(new_lines)
	