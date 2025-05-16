extends Control


func _on_credits_button_pressed() -> void:
	var game = get_tree().root.get_node("Game")
	game.load_screen_to_scene("res://scenes/menus/credits_menu.tscn")
