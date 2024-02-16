extends Node2D

# Incrementar cantidad de cartas 
@onready var cont = get_node("/root/GlobalSignals").contmano
# Variable para retener el reposicionamiento cuando coges la carta
var xlock = true
# Altura a la que se encuentra la mano
var ypos = 599
# Variable para guardar la posicion de la mano de cada carta
var myhandpos = 0
# Determina si la carta ya ha sido colocada o no
var colocada = false
# Variable pa saber si la he soltao en el medio
var soltarMedio = false
# Variable para controlar que no se coja mas de una carta a la vez
var onelock = false

var prueba = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Carta creada")
	get_node("/root/GlobalSignals").contmano += 1
	get_node("/root/Tablero/Game Logic/ZonaMano").vectorPosiciones.append({"xposition": get_node("/root/Tablero/Game Logic/ZonaMano").position.x,"ocupado": false,})
	GlobalSignals.locatespot.emit()
	z_index = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (Input.is_action_pressed("Left-click") and onelock == false):
		xlock = false
		if (get_local_mouse_position().x > -40 and get_local_mouse_position().x < 40 and get_local_mouse_position().y < 40 and get_local_mouse_position().y > -40):
			position = get_global_mouse_position()
			scale.x = 2
			scale.y = 2
			z_index = 4
		else:
			onelock = true
			
	else:
		if (Input.is_action_just_released("Left-click")):
			onelock = false
		z_index = 3
		if(position.x > 555 and position.x < 635 and position.y > 370 and position.y < 450):
			soltarMedio = true
			print("Posicion valida para soltar")
		else:
			
			xlock = true
			position.y = ypos
			scale.x = 1
			scale.y = 1
		if (get_local_mouse_position().x > -40 and get_local_mouse_position().x < 40 and get_local_mouse_position().y < 40 and get_local_mouse_position().y > -40):
				scale.x = 1.5
				scale.y = 1.5
		
	
	
	if (xlock == true):
		for n in get_node("/root/Tablero/Game Logic/ZonaMano").possize:
			if (position.x != get_node("/root/Tablero/Game Logic/ZonaMano").vectorPosiciones[n].xposition and get_node("/root/Tablero/Game Logic/ZonaMano").vectorPosiciones[n].ocupado == false and colocada == false):
				myhandpos = get_node("/root/Tablero/Game Logic/ZonaMano").vectorPosiciones[n].xposition
				get_node("/root/Tablero/Game Logic/ZonaMano").vectorPosiciones[n].ocupado = true
				colocada = true
		position.x = myhandpos

	if (soltarMedio == true):
		GlobalSignals.Luz_Up = GlobalSignals.Luz_Up + 0.001
		position.x = 595
		position.y = 410
		soltarMedio = false
	


