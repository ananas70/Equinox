extends Area2D

@onready var door_sprite = $AnimatedSprite2D

var opened := false  # pentru control

func _unhandled_input(event):
	# debug
	var game = get_tree().root.get_node("Game")
	if event.is_action_pressed("win_last_level"):  # definește această acțiune în Input Map
		open_door()

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		print("La usa!!")
		if get_node("../GameManager").chest_opened:
			open_door()

func open_door():
	if opened:
		return # deja deschisa, nu mai face nimic
	opened = true
	
	door_sprite.play("open")
	await door_sprite.animation_finished
	# Wait some more frames
	await get_tree().create_timer(0.8).timeout
	
	# După animația de deschidere
	var game = get_tree().root.get_node("Game")
	game.goto_next_season()
