extends Node

class_name PlayerHitboxDamage

var parentNode
var direccion: String
var posicion: Vector2
var idDamage: int
var instance

var arrow = preload("res://scenes/Items/AllyItems/ally_arrow.tscn")
var slash = preload("res://scenes/Items/AllyItems/ally_slash.tscn")

func setup(parent,body,direct,id):
	parentNode = parent
	posicion = Vector2(body.global_position)
	direccion = direct
	idDamage = id

func createDamage():
	match idDamage:
		1:
			instance = arrow.instantiate()
			instance.timer = 2
			instance.canMove = true
		2:
			instance = slash.instantiate()
			instance.timer = 0.35
			instance.canMove = false
	instance.direction = direccion
	instance.position = posicion
	parentNode.add_child(instance)
