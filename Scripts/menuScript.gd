extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Iniciar.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://Escenas/Tablero.tscn")


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/optionsMenu.tscn")


func _on_salir_pressed():
	get_tree().quit()
