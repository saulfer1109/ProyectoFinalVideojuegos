extends Node

class_name PlayerHitboxDamage

var parentNode
var direccion: String
var posicion: Vector2
var idDamage: int

var arrow = preload("res://scenes/Items/AllyItems/ally_arrow.tscn")

func setup(body,direct,id):
	parentNode = body.get_parent()
	posicion = Vector2(body.position)
	direccion = direct
	idDamage = id

func createDamage():
	var instance = arrow.instantiate()
	instance.direction = direccion
	instance.position = posicion
	parentNode.add_child(instance)
