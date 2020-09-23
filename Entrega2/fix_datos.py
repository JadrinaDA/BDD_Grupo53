import os

with open("Datos/personal_instalacion.csv", "r") as archivo:
	info = archivo.readlines()
	new_info = []
	for line in info:
		line = line.strip().split(",")
		if line[3] == "mujer":
			line[3] = "F"
		else:
			line[3] = "M"
		new_line = [line[1], line[0], line[2], line[3], line[4]]
		new_info.append(new_line)

with open("Datos/new_persona.csv", "w") as new_archivo:
	new_lines = []
	for line in new_info:
		new_string = line[0] + "," + line[1] + "," + line[2] + "," + line[3] + "\n"
		new_lines.append(new_string)
	new_archivo.writelines(new_lines)
	
