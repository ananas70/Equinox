extends CharacterBody2D

const NORMAL_SPEED = 400.0
const ICE_SPEED = 600.0
const JUMP_VELOCITY = -900.0
const SLIDE_DECELERATION = 0.5
const NORMAL_DECELERATION = 40
const SLIDE_GRACE_TIME = 0.00035 * ICE_SPEED  # Half a second of sliding after ice

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var slide_timer = 0.0

var in_wind := false

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Detect ice
	var is_on_ice = false
	if is_on_floor() and $RayCast2D.is_colliding():
		var floor_type = $RayCast2D.get_collider()
		if floor_type and floor_type.is_in_group("ice"):
			is_on_ice = true

	# Handle sliding logic
	var speed
	if is_on_ice:
		slide_timer = SLIDE_GRACE_TIME  # Reset slide timer when on ice
		speed = ICE_SPEED
	else:
		slide_timer = max(slide_timer - delta, 0)  # Countdown
		speed = NORMAL_SPEED
		
	# Handle wind gliding
	if in_wind:
		velocity.y += -300

	# Adjust deceleration
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		var deceleration 
		if slide_timer > 0:
			deceleration = SLIDE_DECELERATION
		else:
			deceleration = NORMAL_DECELERATION
		velocity.x = move_toward(velocity.x, 0, deceleration)

	move_and_slide()

	# Flip sprite
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

	# Animations
	if not is_on_floor():
		sprite_2d.animation = "jumping"
	elif is_on_ice or slide_timer > 0:
		sprite_2d.animation = "slipping"
	elif abs(velocity.x) > 1 and slide_timer <= 0:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
		
func _ready() -> void:
	add_to_group("player")
