extends CharacterBody2D

@export var speed: int=75
var typeDamage = 1
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D 
@onready var marker = $Marker2D
@onready var actionArea = $Marker2D/Area2D
@onready var hitboxDamage = $HitboxDamage
@onready var animationTree = $AnimationTree
@onready var bodyDetection = $BodyDetection

var moveDirection = Vector2.ZERO
var canDamage = true
var nearestActionable: ActionArea
var direccionHitDamage = "DOWN"
var hitboxDamageScript: PlayerHitboxDamage = PlayerHitboxDamage.new()
var dataNode
var configController

func _ready():
	animationTree.active = true
	dataNode = get_node("/root/MainRoom/DataController")
	configController = get_node("/root/MainRoom/ConfigController")

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
		
func _physics_process(_delta):
	typeDamage = dataNode.idObject
	if configController.canStaticMove:
		velocity = position.direction_to(configController.posToMove) * (speed * 2)
		move_and_slide()
		
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(1)
			if collision.get_collider() is StaticBody2D || position == configController.posToMove:
				configController.canStaticMove = false
				configController.canMovePlayer = true
		if position == configController.posToMove:
				configController.canStaticMove = false
				configController.canMovePlayer = true
		
	if configController.canMovePlayer:
		if canDamage:
			detection_damage()
		validateInput()
		animateMovement()
		move_and_slide()
		check_actionables()
		
func detection_damage():
	var areas: Array[Area2D] = bodyDetection.get_overlapping_areas()
	for area in areas:
		if canDamage:
			dataNode.health = dataNode.health - 1
			canDamage = false
			modulate = Color(1,0.3,0.3)
			get_tree().create_timer(3).timeout.connect(activeDamage)

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
	
	if event.is_action_pressed("key_enter"):
		var invNode = get_node("/root/MainRoom/CanvasLayer/UIGeneralGroup/InventorySystem")
		if invNode.activeInventory == false:
			configController.canMovePlayer = false
			invNode.activeInventory = true
			return
		else:
			configController.canMovePlayer = true
			invNode.activeInventory = false
			return
		
	if configController.canMovePlayer == true:
		if event.is_action_pressed("key_x"):
			hitboxDamageScript.setup(self.get_parent(),Vector2(hitboxDamage.global_position),direccionHitDamage,2)
			hitboxDamageScript.createDamage()
			attack_animation()
		if event.is_action_pressed("key_z"):
			configController.canMovePlayer = false
			hitboxDamageScript.setup(self.get_parent(),Vector2(hitboxDamage.global_position),direccionHitDamage,typeDamage)
			hitboxDamageScript.createDamage()
			item_animation()
	
		if event.is_action_pressed("ui_select") && nearestActionable != null:
			if is_instance_valid(nearestActionable):
				nearestActionable.emit_signal("actionated")
	
func attack_animation():
	animationTree["parameters/conditions/Attacking"] = true
	animationTree["parameters/conditions/Idleing"] = false
	animationTree["parameters/conditions/Walking"] = false
	configController.canMovePlayer = false
	await get_tree().create_timer(0.35).timeout
	animationTree["parameters/conditions/Attacking"] = false
	configController.canMovePlayer = true

func item_animation():
	match(direccionHitDamage):
		"UP":
			sprite.frame = 52
		"RIGHT":
			sprite.frame = 61
		"DOWN":
			sprite.frame = 43
		"LEFT":
			sprite.frame = 70
	
func activeDamage():
	modulate = Color(1,1,1)
	canDamage = true
	
