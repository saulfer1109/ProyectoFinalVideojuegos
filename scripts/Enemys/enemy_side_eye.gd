extends CharacterBody2D

@onready var actionArea = $Area2D
@onready var detectionArea = $DetectionArea
@export var enemyHealth = 5
var directions = [Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN,Vector2.ZERO]
var moveDirection
var speed: int = 40

var rng = RandomNumberGenerator.new()
var randomNumber = 0

var playerLocated = false
var player

func _physics_process(_delta: float) -> void:
	check_Death()
	check_actionables()
	check_Near_Player()
	random_Move()
	move_and_slide()
	randomNumber -= 1

func check_Death():
	if enemyHealth <= 0:
		queue_free()

func check_actionables() -> void:
	var areas: Array[Area2D] = actionArea.get_overlapping_areas()
	for area in areas:
		enemyHealth -= 1
		area.get_parent().queue_free()
		
func check_Near_Player():
	if playerLocated == false:
		var areas: Array[Area2D] = detectionArea.get_overlapping_areas()
		for area in areas:
			player = area.get_parent()
			playerLocated = true

func random_Move():
	if randomNumber == 0:
		randomNumber = rng.randi_range(15,25)
		moveDirection = directions.pick_random()
		
	if not playerLocated:
		velocity = moveDirection * speed
	else:
		velocity = position.direction_to(player.position) * speed
	
	
