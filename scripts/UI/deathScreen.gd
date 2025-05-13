extends Control

var dataNode

func _ready() -> void:
	self.visible = false
	dataNode = get_node("/root/MainRoom/DataController")
	dataNode.gameOver.connect(showScreen)
	
func showScreen():
	self.visible = true
