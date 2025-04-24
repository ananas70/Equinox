extends Control


func _on_resume_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	var options_scene = preload("res://scenes/menus/options_menu.tscn").instantiate()
	options_scene.previous_scene_path = get_tree().current_scene.scene_file_path
	get_tree().current_scene.add_child(options_scene)


func _on_quit_pressed() -> void:
	# TODO: eventual fa si salvare
	get_tree().quit()
