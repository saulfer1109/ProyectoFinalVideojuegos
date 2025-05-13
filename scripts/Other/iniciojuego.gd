extends Node2D
var configController

func _ready() -> void:
	configController = get_node("/root/MainRoom/ConfigController")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/DialogueInicioJuego.dialogue"),"dialogo_inicio")
	
func _on_dialogue_ended(_resource:DialogueResource):
	configController.canMovePlayer = true
