extends Control


func _on_return_pressed() -> void:
	var game = get_tree().root.get_node("Game")
	game.load_screen_to_scene("res://scenes/menus/main_menu.tscn")
