extends Area2D

@onready var game_manager: Node = %GameManager



func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		queue_free()
		game_manager.collect_point()
		get_parent().get_node("UI").activate_icon("spring")

	
