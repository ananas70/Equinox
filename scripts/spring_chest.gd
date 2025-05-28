extends Area2D

@export var has_key: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var question_mark: Sprite2D = $QuestionMark
@onready var apple: Sprite2D = $AppleContainer/Apple

var shaking := false  # pentru control
var opened := false  # pentru control

func _ready():
	question_mark.visible = false
	apple.visible = false

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		if has_key:
			open_chest()
		else:
			start_shaking()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D" and opened == false:
		stop_shaking()

func open_chest():
	if opened:
		return # deja deschis, nu mai face nimic
	opened = true
	get_node("../GameManager").chest_opened = true
	
	animated_sprite_2d.play("open")
	await animated_sprite_2d.animation_finished
	$AnimationPlayer.play("pop_apple")


func start_shaking():
	if shaking:
		return  # deja se zguduie

	shaking = true
	question_mark.visible = true

	while shaking:
		animated_sprite_2d.play("shake")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("default")
		await get_tree().create_timer(0.2).timeout  # mică pauză

func stop_shaking():
	shaking = false
	question_mark.visible = false
	animated_sprite_2d.play("default")
