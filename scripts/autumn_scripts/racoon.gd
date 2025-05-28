extends CharacterBody2D

const SPEED = 60
var direction = 1
var stunned := false  # blocăm mișcarea în timpul damage

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var racoon = $AnimatedSprite2D

@export var max_health := 3
var current_health := max_health

func _ready():
	add_to_group("enemy")

func take_damage():
	if stunned:
		return  # ignoră lovitura dacă e deja în damage

	current_health -= 1
	$HealthBar.visible = true
	$HealthBar.value = current_health

	stunned = true
	velocity = Vector2.ZERO
	racoon.play("damage")
	set_physics_process(false)

	await racoon.animation_finished

	stunned = false
	set_physics_process(true)

	if current_health <= 0:
		die()
		
	racoon.play("default")

func die():
	queue_free()
	
func _physics_process(delta: float) -> void:
	if stunned:
		return  # nu ne mișcăm în timpul damage
		
	if ray_cast_right.is_colliding():
		direction = -1
		racoon.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		racoon.flip_h = false
	
	velocity.x = direction * SPEED
	velocity.y = 0
	move_and_slide()
