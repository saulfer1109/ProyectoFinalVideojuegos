extends Node

signal dataChange
signal gameOver

func _ready():
	loadGame()
	

var actualObject: Texture2D:
	get:
		return actualObject
	set(value):
		actualObject = value
		dataChange.emit()

var idObject: int:
	get:
		return idObject
	set(value):
		idObject = value
		dataChange.emit()

var coins: int=0:
	get:
		return coins
	set(value):
		coins += clamp(value, 1, max_coins)
		if(coins>=max_coins):
			coins=max_coins
		dataChange.emit()
		saveGame()

var max_coins: int=99:
	get:
		return max_coins
	set(value):
		max_coins=max(value,max_coins)
		dataChange.emit();
		saveGame()
		
var magic: int=0:
	get:
		return magic
	set(value):
		magic += clamp(value, 1, max_magic)
		if(magic>=max_magic):
			magic=max_magic
		dataChange.emit()
		saveGame()

var max_magic: int=100:
	get:
		return max_magic
	set(value):
		max_magic=max(value,max_magic)
		dataChange.emit();
		saveGame()

var bombs: int=0:
	get:
		return bombs
	set(value):
		bombs += clamp(value, 1, max_bombs)
		if(bombs>=max_bombs):
			bombs=max_bombs
		dataChange.emit()
		saveGame()

var max_bombs: int=50:
	get:
		return max_bombs
	set(value):
		max_bombs=max(value,max_bombs)
		dataChange.emit();
		saveGame()
		
var arrow: int=5:
	get:
		return arrow
	set(value):
		arrow += clamp(value, 1, max_arrow)
		if(arrow>=max_arrow):
			arrow=max_arrow
		dataChange.emit()
		saveGame()

var max_arrow: int=99:
	get:
		return max_arrow
	set(value):
		max_arrow=max(value,max_arrow)
		dataChange.emit();
		saveGame()
		
var health: int=0:
	get:
		return health
	set(value):
		health = clamp(value, 0, max_health)
		if(health >= max_health):
			health = max_health
		if (health == 0):
			gameOver.emit()
		dataChange.emit()
		saveGame()

var max_health: int=5:
	get:
		return max_health
	set(value):
		max_health=max(value,max_health)
		dataChange.emit();
		saveGame()
		
func saveGame():
	var file = FileAccess.open("user://dataGame.json", FileAccess.WRITE)
	
	var data = {}
	data["coins"] = coins
	data["maxCoins"] = max_coins
	data["magic"] = magic
	data["maxMagic"] = max_magic
	data["bombs"] = bombs
	data["maxBombs"] = max_bombs
	data["arrows"] = arrow
	data["maxArrows"] = max_arrow
	data["health"] = health
	data["maxHealth"] = max_health
	
	var json = JSON.stringify(data)
	file.store_string(json)
	file.close()
	

func loadGame():
	var file = FileAccess.open("user://dataGame.json", FileAccess.READ)
	if file == null:
		return
	
	var json = file.get_as_text()
	var data = JSON.parse_string(json)
	
	data["coins"] = coins
	data["maxCoins"] = max_coins
	data["magic"] = magic
	data["maxMagic"] = max_magic
	data["bombs"] = bombs
	data["maxBombs"] = max_bombs
	data["arrows"] = arrow
	data["maxArrows"] = max_arrow
	data["health"] = health
	data["maxHealth"] = max_health
	
	file.close()
	
