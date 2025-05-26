extends CharacterBody2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var grey_trex: AnimatedSprite2D = $GreyTrex

@export var max_health := 3
var current_health := max_health

func _ready():
	add_to_group("enemy")

func take_damage():
	current_health -= 1
	print("Inamic lovit! Viață rămasă: ", current_health)
	if current_health <= 0:
		die()

func die():
	queue_free()

func _physics_process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		grey_trex.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		grey_trex.flip_h = false

	velocity.x = direction * SPEED
	velocity.y = 0
	move_and_slide()
