extends Control


func _on_start_pressed() -> void:
	Functions.load_screen_to_scene("res://scenes/autumn_scenes/autumn_scene.tscn")


func _on_options_pressed() -> void:
	var options_scene = preload("res://scenes/menus/options_menu.tscn").instantiate()
	options_scene.previous_scene_path = get_tree().current_scene.scene_file_path
	get_tree().current_scene.add_child(options_scene)
	
func _on_exit_pressed() -> void:
	get_tree().quit()
