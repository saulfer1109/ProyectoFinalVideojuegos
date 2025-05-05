extends CharacterBody2D

@export var speed: int = 140
var direction
var moveDirection
func _ready() -> void:
	get_tree().create_timer(2).timeout.connect(expireTime)


func _process(delta: float) -> void:
	match direction:
		"DOWN":
			rotation = deg_to_rad(0)
			moveDirection = Vector2.DOWN
		"UP":
			rotation = deg_to_rad(180)
			moveDirection = Vector2.UP
		"RIGHT":
			rotation = deg_to_rad(270)
			moveDirection = Vector2.RIGHT
		"LEFT":
			rotation = deg_to_rad(90)
			moveDirection = Vector2.LEFT
	velocity = moveDirection * speed
	move_and_slide()

func expireTime():
	queue_free()
	
