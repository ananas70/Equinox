extends CharacterBody2D

const GRAVITY := 1200.0
const JUMP_FORCE := -450.0
const JUMP_INTERVAL := 1.5

var direction = 1
var stunned := false  # blocăm mișcarea în timpul damage
var jump_timer := 0.0

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var blue_slime: AnimatedSprite2D = $BlueSlime

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
	if not blue_slime.is_playing() or blue_slime.animation != "jump":
		blue_slime.play("default")
		
	move_and_slide()

func jump():
	velocity.y = JUMP_FORCE
	blue_slime.play("jump")

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
