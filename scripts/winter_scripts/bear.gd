extends CharacterBody2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var bear: AnimatedSprite2D = $Bear

func _physics_process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		bear.flip_h = false
	elif ray_cast_left.is_colliding():
		direction = 1
		bear.flip_h = true

	velocity.x = direction * SPEED
	velocity.y = 0
	move_and_slide()
