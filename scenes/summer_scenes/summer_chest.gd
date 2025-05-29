extends Area2D

@export var has_key: bool = false

@onready var chest_sprite = $AnimatedSprite2D
@onready var question_mark = $QuestionMark
@onready var honey = $HoneyContainer/Honey

var shaking := false  # pentru control
var opened := false  # pentru control

func _ready():
	question_mark.visible = false
	honey.visible = false

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
	
	chest_sprite.play("open")
	await chest_sprite.animation_finished
	$AnimationPlayer.play("pop_honey")

func start_shaking():
	if shaking:
		return  # deja se zguduie

	shaking = true
	question_mark.visible = true

	while shaking:
		chest_sprite.play("shake")
		await chest_sprite.animation_finished
		chest_sprite.play("default")
		await get_tree().create_timer(0.2).timeout  # mică pauză

func stop_shaking():
	shaking = false
	question_mark.visible = false
	chest_sprite.play("default")
