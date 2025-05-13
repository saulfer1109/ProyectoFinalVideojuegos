extends Area2D

@export var nextScene: PackedScene

func _on_body_entered(body:Node2D):
	if (body.name == "Player")	:
		var mainNode = get_node("/root/MainRoom")
		var nodeDelete = mainNode.get_child(2)
		nodeDelete.queue_free()
		var instance = nextScene.instantiate()
		instance.get_node("Player").canMove = true
		mainNode.call_deferred("add_child",instance)
