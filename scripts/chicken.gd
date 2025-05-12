extends Node2D
const speed = 300
var direction = 1

@onready var screen_width := get_viewport_rect().size.x
@onready var sprite := $AnimatedSprite2D

func _process(delta: float) -> void:
	# Mișcare pe X
	position.x += direction * speed * delta

	var sprite_width = sprite.sprite_frames.get_frame_texture(sprite.animation, 0).get_size().x

	# Dacă iese complet din ecran în dreapta
	if position.x > screen_width:
		position.x = -sprite_width

	# Dacă iese complet din ecran în stânga
	if position.x < -sprite_width:
		position.x = screen_width
