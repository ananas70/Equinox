extends CharacterBody2D

var stunned := false  # blocăm acțiunile în timpul damage

@onready var health_bar: TextureProgressBar = $HealthBar
@onready var butterfly: AnimatedSprite2D = $AnimatedSprite2D

@export var max_health := 6
var current_health := max_health

func _ready():
	add_to_group("enemy")
	health_bar.visible = false
	health_bar.value = current_health
	print("🦋 ButterflyBlue a intrat în grupul enemy")

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
	butterfly.play("damage")
	set_physics_process(false)

	await butterfly.animation_finished

	stunned = false
	set_physics_process(true)

	if current_health <= 0:
		print("💀 ButterflyBlue a murit")
		die()
	else:
		print("✅ Nu a murit încă, continuăm animația default")

	butterfly.play("default")

func die():
	print("🧨 Se apelează queue_free()")
	queue_free()

func _physics_process(delta: float) -> void:
	if stunned:
		return

	# Nu ne mișcăm deloc, așa că nu setăm velocity sau direcție
