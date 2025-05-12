extends CharacterBody2D

@export var speed: int=50
@export var typeDamage = 2
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D 
@onready var marker = $Marker2D
@onready var actionArea = $Marker2D/Area2D
@onready var hitboxDamage = $HitboxDamage
@onready var animationTree = $AnimationTree
var moveDirection = Vector2.ZERO
var canMove = true
var nearestActionable: ActionArea
var direccionHitDamage = "DOWN"
var hitboxDamageScript: PlayerHitboxDamage = PlayerHitboxDamage.new()

func _ready():
	animationTree.active = true

func validateInput():
	moveDirection= Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	velocity=moveDirection*speed
	
func animateMovement():
	if velocity.length()==0:
		animationTree["parameters/conditions/Idleing"] = true
		animationTree["parameters/conditions/Walking"] = false
	else:
		direccionHitDamage = "DOWN"
		marker.rotation = deg_to_rad(0)
		hitboxDamage.rotation = deg_to_rad(0)
		if velocity.x < 0:
			direccionHitDamage = "LEFT"
			marker.rotation = deg_to_rad(90)
			hitboxDamage.rotation = deg_to_rad(90)
		elif velocity.x > 0:
			direccionHitDamage = "RIGHT"
			marker.rotation = deg_to_rad(-90)
			hitboxDamage.rotation = deg_to_rad(-90)
		elif velocity.y < 0:
			direccionHitDamage = "UP"
			marker.rotation = deg_to_rad(180)
			hitboxDamage.rotation = deg_to_rad(180)
		animationTree["parameters/Idle/blend_position"] = moveDirection
		animationTree["parameters/Walk/blend_position"] = moveDirection
		animationTree["parameters/Attack/blend_position"] = moveDirection
		animationTree["parameters/conditions/Idleing"] = false
		animationTree["parameters/conditions/Walking"] = true
		
func _physics_process(delta):
	if canMove == true:
		validateInput()
		animateMovement()
		move_and_slide()
		check_actionables()

func check_actionables() -> void:
	var areas: Array[Area2D] =actionArea.get_overlapping_areas()
	var shortDistance: float = INF
	var nextActionable: ActionArea = null
	for area in areas:
		var distance: float = area.global_position.distance_to(global_position)
		if distance < shortDistance:
			shortDistance = distance
			nextActionable = area
	
	if nextActionable != null:
		if nextActionable != nearestActionable or not is_instance_valid(nextActionable):
			nearestActionable =nextActionable
			print(nearestActionable)
	else:
		nearestActionable = null
		
func _unhandled_input(event: InputEvent) -> void:
	if canMove == true:
		if event.is_action_pressed("ui_select"):
			hitboxDamageScript.setup(self.get_parent(),hitboxDamage,direccionHitDamage,typeDamage)
			hitboxDamageScript.createDamage()
			attack_animation()

		if event.is_action_pressed("ui_accept") && nearestActionable != null:
			if is_instance_valid(nearestActionable):
				nearestActionable.emit_signal("actionated")
	
func attack_animation():
	animationTree["parameters/conditions/Attacking"] = true
	animationTree["parameters/conditions/Idleing"] = false
	animationTree["parameters/conditions/Walking"] = false
	canMove = false
	await get_tree().create_timer(0.35).timeout
	animationTree["parameters/conditions/Attacking"] = false
	canMove = true
	
	
