extends CharacterBody2D

const SPEED = 60
var direction = 1
var stunned := false  # blocăm mișcarea în timpul damage

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var blue_slime: AnimatedSprite2D = $BlueSlime

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
	blue_slime.play("damage")
	set_physics_process(false)

	await blue_slime.animation_finished

	stunned = false
	set_physics_process(true)

	if current_health <= 0:
		die()
		
	blue_slime.play("default")

func die():
	queue_free()
