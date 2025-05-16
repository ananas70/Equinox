extends Area2D

@onready var timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	var game = get_tree().root.get_node("Game")
	game.load_level(game.anotimpuri[game.current_season_index])
