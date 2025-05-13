extends Area2D

@export var IdItem: int=0
@export var value: int=0
var dataNode
func _ready():
	dataNode=get_node("/root/MainRoom/DataController")
	match IdItem:
		1:
			$Sprite2D.texture=preload("res://resourses/Items/Coin.png")
		2:
			$Sprite2D.texture=preload("res://resourses/Items/Magic.png")
		3:
			$Sprite2D.texture=preload("res://resourses/Items/Bomb.png")
		4:
			$Sprite2D.texture=preload("res://resourses/Items/Arrow.png")
		5:
			$Sprite2D.texture=preload("res://resourses/Items/Heart.png")

func _on_body_entered(body:Node2D):
	if(body.name=="Player"):
		colectItem()

func colectItem():
	match IdItem:
		1:
			dataNode.coins=value
		2:
			dataNode.magic=value
		3:
			dataNode.bombs=value
		4:
			dataNode.arrow=value
		5:
			dataNode.health=dataNode.health + value
	queue_free()
