extends Control


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/credits_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
