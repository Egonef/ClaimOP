extends Node

@export var address = "127.0.0.1"
@export var port = 8081

var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(JugadorConectado)
	multiplayer.peer_connected.connect(saber_id)
	multiplayer.peer_disconnected.connect(JugadorDesconectado)
	multiplayer.connected_to_server.connect(JugadorConectadoServer)
	multiplayer.connection_failed.connect(JugadorDesconectadoServer)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func JugadorConectado(id):
	print("Jugador conectao: " + str(id))

func JugadorDesconectado(id):
	print("Jugador desconectao: " + str(id))

func JugadorConectadoServer():
	print("Conectao al servidor")

func JugadorDesconectadoServer():
	print("Conexion fallida con el servidor")

func saber_id(id):
	if (id == 1):
		print("Soy el servidor")
	else:
		print("Soy el cliente, y mi id es: " + str(id))

@rpc("any_peer","call_local")
func entrar_en_partida():
	var escena = load("res://Escenas/Tablero.tscn").instantiate()
	get_tree().root.add_child(escena)
	self.visible = false
 




func _on_crear_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port,2)
	if error != OK:
		print("No se ha podido crear la partida. Codigo de error:" + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Partida creada con éxito, esperando jugadores.")

func _on_unirse_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address,port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)

func _on_volver_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")


func _on_iniciar_partida_pressed():
	entrar_en_partida.rpc()
