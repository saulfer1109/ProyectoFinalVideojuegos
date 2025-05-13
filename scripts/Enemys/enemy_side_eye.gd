extends CharacterBody2D

@onready var actionArea = $Area2D

func _physics_process(_delta: float) -> void:
	check_actionables()

func check_actionables() -> void:
	var areas: Array[Area2D] = actionArea.get_overlapping_areas()
	for area in areas:
		queue_free()
		
