extends Control


func _on_main_menu_pressed() -> void:
	var game = get_tree().root.get_node("Game")
	game.load_screen_to_scene("res://scenes/menus/main_menu.tscn")


func _on_credits_pressed() -> void:
	var game = get_tree().root.get_node("Game")
	game.load_screen_to_scene("res://scenes/menus/credits_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
