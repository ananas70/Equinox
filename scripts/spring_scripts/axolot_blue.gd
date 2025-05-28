extends CharacterBody2D

const SPEED = 60
var direction = 1
var stunned := false  # blocăm mișcarea în timpul damage

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var axolot_blue: AnimatedSprite2D = $AxolotBlue
@onready var health_bar: TextureProgressBar = $HealthBar

@export var max_health := 6
var current_health := max_health

func _ready():
	add_to_group("enemy")
	health_bar.visible = false
	health_bar.value = current_health
	print("🚀 AxolotBlue a intrat în grupul enemy")

func take_damage():
	print("🎯 take_damage() a fost apelată")

	if stunned:
		print("🛑 E deja în stunned, ignorăm lovitura")
		return

	current_health -= 1
	current_health = clamp(current_health, 0, max_health)

	print("❤️ Viața actuală:", current_health)

	health_bar.visible = true
	health_bar.value = current_health

	stunned = true
	velocity = Vector2.ZERO
	axolot_blue.play("damage")
	set_physics_process(false)

	await axolot_blue.animation_finished

	stunned = false
	set_physics_process(true)

	if current_health <= 0:
		print("💀 Inamicul a murit")
		die()
	else:
		print("✅ Nu a murit încă, continuăm animația default")

	axolot_blue.play("default")

func die():
	print("🧨 Se apelează queue_free()")
	queue_free()

func _physics_process(delta: float) -> void:
	if stunned:
		return

	if ray_cast_right.is_colliding():
		direction = -1
		axolot_blue.flip_h = false
	elif ray_cast_left.is_colliding():
		direction = 1
		axolot_blue.flip_h = true

	velocity.x = direction * SPEED
	velocity.y = 0
	move_and_slide()
