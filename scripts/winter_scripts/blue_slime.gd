extends CharacterBody2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var blue_slime: AnimatedSprite2D = $BlueSlime

func _physics_process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		blue_slime.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		blue_slime.flip_h = false

	velocity.x = direction * SPEED
	velocity.y = 0
	move_and_slide()
