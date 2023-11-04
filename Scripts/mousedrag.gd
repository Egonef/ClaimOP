extends StaticBody2D

# Variable para retener el reposicionamiento cuando coges la carta
var xlock = true
# Altura a la que se encuentra la mano
var ypos = 599
# Variable para guardar la posicion de la mano de cada carta
var myhandpos = 0
# Determina si la carta ya ha sido colocada o no
var colocada = false



# Called when the node enters the scene tree for the first time.
func _ready():
	print("Carta creada")
	get_node("/root/Tablero/ZonaMano").vectorPosiciones.append({"xposition": get_node("/root/Tablero/ZonaMano").position.x,"ocupado": false,})
	GlobalSignals.locatespot.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Left-click"):
		xlock = false
		if (get_local_mouse_position().x > -40 and get_local_mouse_position().x < 40 and get_local_mouse_position().y < 40 and get_local_mouse_position().y > -40):
				position = get_global_mouse_position()
				scale.x = 2
				scale.y = 2
	else:
		xlock = true
		position.y = ypos
		scale.x = 1
		scale.y = 1
		if (get_local_mouse_position().x > -40 and get_local_mouse_position().x < 40 and get_local_mouse_position().y < 40 and get_local_mouse_position().y > -40):
				scale.x = 1.5
				scale.y = 1.5
	
	
	if (xlock == true):
		for n in get_node("/root/Tablero/ZonaMano").possize:
			if (position.x != get_node("/root/Tablero/ZonaMano").vectorPosiciones[n].xposition and get_node("/root/Tablero/ZonaMano").vectorPosiciones[n].ocupado == false and colocada == false):
				myhandpos = get_node("/root/Tablero/ZonaMano").vectorPosiciones[n].xposition
				get_node("/root/Tablero/ZonaMano").vectorPosiciones[n].ocupado = true
				colocada = true
		position.x = myhandpos





	
