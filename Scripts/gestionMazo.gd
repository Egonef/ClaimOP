extends Node2D

#ID del cliente

var clientID = 0

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
			#print("Found file: " + file_name)
			var addedcard = load("res://Escenas/cartas/"+file_name)
			vectorMazo.push_front(addedcard)
			file_name = dir.get_next()
			sincronizarmazo.rpc_id(clientID, vectorMazo)
	else:
		print("An error occurred when trying to access the path.")


func actualizarnumcartas():
	if ( multiplayer.get_unique_id() == 1 ):
		#print("Soy el host y voy a guardar mi numero de cartas")
		GlobalSignals.numcartasHost = cont
	else:
		#print("Soy el cliente, mi id es: " + str(multiplayer.get_unique_id()) + "y voy a enviarle al servidor mi numero de cartas")
		actualizarnumcartasdevuelto.rpc_id(1,cont)

@rpc("any_peer","call_remote")
func actualizarnumcartasdevuelto(contClient):
	#print("Soy el host, y voy a guardar el numero de cartas, que tiene el cliente")
	GlobalSignals.numcartasClient = contClient

@rpc("any_peer","call_remote")
func sincronizarmazo(vectorCartasRestantes):
	print("Entramos en sincronizar mazo")
	if (multiplayer.get_unique_id() != 1):
		print("Soy el cliente y recojo el mazo")
		vectorMazo = vectorCartasRestantes
	

func checkvalores():
	if Input.is_action_pressed("Space"):
		print("Tecla espacio pulsada")
		print("Los valores del Global signal son:")
		print("cartasHost:" + str(GlobalSignals.numcartasHost) + "cartasClient" + str(GlobalSignals.numcartasClient))

#Enviamos el id del client al host para que pueda enviarnos informacion posteriormente
func sendIDToHost():
	if (multiplayer.get_unique_id() == 1): #Si soy el host no hago nada
		print("Esperando a recibir el id del cliente")
	else:
		print("Soy el cliente y voy a mandarle al servidor mi id")
		saveClientID.rpc_id(1,multiplayer.get_unique_id())
		print("mandado")

#Guardo el ID que me ha enviado el cliente
@rpc("any_peer","call_remote")
func saveClientID(id):
	print("Entrando en funcion saveClientID")
	clientID = id
	print("Soy el host y he guardado el ID del cliente exitosamente:" + str(clientID))

# Called when the node enters the scene tree for the first time.
func _ready():
	sendIDToHost()
	#Carga cartas en vector
	dir_contents("res://Escenas/cartas/")
	#randomiza vector
	vectorMazo.shuffle()

#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA POR QU ENO CONSIGO QU ESE ACTUALICE EL MAZO DEL CLIENTEEEEE
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Se añade carta a la mano si hay hueco
	if(multiplayer.get_unique_id() == 1):
		cont = get_node("/root/GlobalSignals").contmano
		if (cont < 13 and vectorMazo.size() > 0):
			print("Saco carta para el host")
			#print("Contador: ", cont)
			var inst
			if vectorMazo[vectorMazo.size()-1] is PackedScene:
				inst = vectorMazo[vectorMazo.size()-1].instantiate()
			else:
				print("Error: intentando instanciar un objeto que no es una PackedScene")
			add_sibling(inst)
			vectorMazo.pop_back()
			actualizarnumcartas()
			sincronizarmazo.rpc_id(clientID, vectorMazo)
	else:

		cont = get_node("/root/GlobalSignals").contmano
		if (cont < 13 and vectorMazo.size() > 0):
			print("Saco carta para el cliente")
			
			#print("Contador: ", cont)
			var inst
			if vectorMazo[vectorMazo.size()-1] is PackedScene:
				inst = vectorMazo[vectorMazo.size()-1].instantiate()
			else:
				print("Error: intentando instanciar un objeto que no es una PackedScene")
			add_sibling(inst)
			vectorMazo.pop_back()
			actualizarnumcartas()
	checkvalores()
