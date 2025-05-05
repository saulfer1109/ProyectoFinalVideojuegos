extends Node2D
@export var objects: Array[PackedScene]

@onready var area = $ActionArea

func _ready() -> void:
	area.actionated.connect(actioned)
	
func actioned():
	for obj in objects:
		print(obj.instantiate().name)
