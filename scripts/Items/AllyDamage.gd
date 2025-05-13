extends CharacterBody2D

@export var speed: int = 140
var direction
var moveDirection
var timer
var canMove
var oneTime = true

var configController
func _ready() -> void:
	configController = get_node("/root/MainRoom/ConfigController")
	get_tree().create_timer(timer).timeout.connect(expireTime)
	configController.canMovePlayer = true


func _process(_delta: float) -> void:
	match direction:
		"DOWN":
			rotation = deg_to_rad(0)
			moveDirection = Vector2.DOWN
			if oneTime == true:
				oneTime = false
				position.y = position.y + 10
		"UP":
			rotation = deg_to_rad(180)
			moveDirection = Vector2.UP
			if oneTime == true:
				oneTime = false
				position.y = position.y - 10
		"RIGHT":
			rotation = deg_to_rad(270)
			moveDirection = Vector2.RIGHT
			if oneTime == true:
				oneTime = false
				position.x = position.x + 10
		"LEFT":
			rotation = deg_to_rad(90)
			moveDirection = Vector2.LEFT
			if oneTime == true:
				oneTime = false
				position.x = position.x - 10
	if canMove == true:
		velocity = moveDirection * speed
		move_and_slide()

func expireTime():
	queue_free()
	
