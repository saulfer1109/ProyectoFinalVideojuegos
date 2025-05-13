extends Node2D

var canMovePlayer = false
var canStaticMove = false
var posToMove

func movePlayerTo(pos):
	canStaticMove = true
	posToMove = pos
