extends CharacterBody2D

const GRAVITY := 1200.0
const JUMP_FORCE := -250.0
const JUMP_INTERVAL := 2.0

var direction = 1
var stunned := false  # blocăm mișcarea în timpul damage
var jump_timer := 0.0

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var mole: AnimatedSprite2D = $AnimatedSprite2D

@export var max_health := 3
var current_health := max_health

func _ready():
	add_to_group("enemy")
	jump_timer = JUMP_INTERVAL

func _physics_process(delta: float) -> void:
	if stunned:
		return

	# Gravitație
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		jump_timer -= delta
		if jump_timer <= 0:
			jump()
			jump_timer = JUMP_INTERVAL

	# doar pe jos și nu în timpul unei alte animații
	if not mole.is_playing() or mole.animation != "jump":
		mole.play("default")
		
	move_and_slide()

func jump():
	velocity.y = JUMP_FORCE
	mole.play("jump")

func take_damage():
	if stunned:
		return  # ignoră lovitura dacă e deja în damage

	current_health -= 1
	$HealthBar.visible = true
	$HealthBar.value = current_health

	stunned = true
	velocity = Vector2.ZERO
	mole.play("damage")
	set_physics_process(false)

	await mole.animation_finished

	stunned = false
	set_physics_process(true)

	if current_health <= 0:
		die()

	mole.play("default")

func die():
	queue_free()
