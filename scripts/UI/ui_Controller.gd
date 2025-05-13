extends Control

var dataNode

@onready var  lbCoin= $UIStats/Panel/Sprite2D/Label
@onready var  lbFlechas= $UIStats/Panel2/Sprite2D/Label
@onready var  lbBombas= $UIStats/Panel3/Sprite2D/Label
@onready var manaBar= $UIManaBar/TextureProgressBar
@onready var health= $UIHealtContainer/LifeFull
@onready var actualObject = $UIActualObject/Object

func _ready():
	dataNode= get_node("/root/MainRoom/DataController")
	dataNode.dataChange.connect(updateData)
	updateData()

func updateData():
	handleActualObject()
	handleHealthContainers()
	handleMana()
	handleStats()
	
func handleActualObject():
	actualObject.texture = dataNode.actualObject
	
func handleHealthContainers():
	health.size.x=(dataNode.health*8)
	
func handleMana():
	manaBar.value=dataNode.magic
	
func handleStats():
	lbCoin.text = str(dataNode.coins)
	lbBombas.text = str(dataNode.bombs)
	lbFlechas.text = str(dataNode.arrow)
