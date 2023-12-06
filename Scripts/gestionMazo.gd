extends Node2D



#Contador global del numero de cartas totales en la mano
@onready var cont = get_node("/root/GlobalSignals").contmano

# Vector donde se guardan las escenas de las cartas
var vectorMazo = []

#Acceder a la carpeta con las escenas de las cartas y rellenar el vector con ellas

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print("Found file: " + file_name)
			var addedcard = load("res://Escenas/cartas/"+file_name)
			vectorMazo.push_front(addedcard)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	


# Called when the node enters the scene tree for the first time.
func _ready():
	#Carga cartas en vector
	dir_contents("res://Escenas/cartas/")
	#randomiza vector
	vectorMazo.shuffle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cont = get_node("/root/GlobalSignals").contmano
	if (cont < 13 and vectorMazo.size() > 0):
		print("Contador: ", cont)
		var inst = vectorMazo[vectorMazo.size()-1].instantiate()
		add_sibling(inst)
		vectorMazo.pop_back()
