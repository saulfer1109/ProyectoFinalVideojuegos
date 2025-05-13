extends Area2D

@export var nextScene: PackedScene

func _on_body_entered(body:Node2D):
	if (body.name == "Player")	:
		var mainNode = get_node("/root/MainRoom")
		var nodeDelete = mainNode.get_child(3)
		nodeDelete.queue_free()
		var instance = nextScene.instantiate()
		mainNode.call_deferred("add_child",instance)
