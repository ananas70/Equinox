extends Control


func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()  # închide meniul


func _on_quit_pressed() -> void:
	#TODO: eventual fa si salvare
	get_tree().paused = false
	var game = get_tree().root.get_node("Game")
	game.load_screen_to_scene("res://scenes/menus/main_menu.tscn")
	queue_free()
