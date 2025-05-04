extends Node

signal dataChange

var coins: int=0:
	get:
		return coins
	set(value):
		coins += clamp(value, 1, max_coins)
		if(coins>=max_coins):
			coins=max_coins
		dataChange.emit()

var max_coins: int=99:
	get:
		return max_coins
	set(value):
		max_coins=max(value,max_coins)
		dataChange.emit();
		
var magic: int=0:
	get:
		return magic
	set(value):
		magic += clamp(value, 1, max_magic)
		if(magic>=max_magic):
			magic=max_magic
		dataChange.emit()

var max_magic: int=999:
	get:
		return max_magic
	set(value):
		max_magic=max(value,max_magic)
		dataChange.emit();

var bombs: int=0:
	get:
		return bombs
	set(value):
		bombs += clamp(value, 1, max_bombs)
		if(bombs>=max_bombs):
			bombs=max_bombs
		dataChange.emit()

var max_bombs: int=50:
	get:
		return max_bombs
	set(value):
		max_bombs=max(value,max_bombs)
		dataChange.emit();
		
var arrow: int=5:
	get:
		return arrow
	set(value):
		arrow += clamp(value, 1, max_arrow)
		if(arrow>=max_arrow):
			arrow=max_arrow
		dataChange.emit()

var max_arrow: int=99:
	get:
		return max_arrow
	set(value):
		max_arrow=max(value,max_arrow)
		dataChange.emit();
		
var health: int=1:
	get:
		return health
	set(value):
		health += clamp(value, 1, max_health)
		if(health>=max_health):
			health=max_health
		dataChange.emit()

var max_health: int=5:
	get:
		return max_health
	set(value):
		max_health=max(value,max_health)
		dataChange.emit();
