extends Node2D

@onready var area2D = $HookArea

var canValidate = false
var configController

func _ready() -> void:
	configController = get_node("/root/MainRoom/ConfigController")
	
func _process(delta: float):
	if canValidate == false:
		validateAreas()

func validateAreas():
	var areas: Array[Area2D] = area2D.get_overlapping_areas()
	for area in areas:
		canValidate = true
		match area.name:
			"NearableItem":
				configController.movePlayerTo(area.global_position)
				get_parent().queue_free()
			"RecolectableItem":
				area.colectItem()
				configController.canMovePlayer = true
				get_parent().queue_free()
		return
