extends Control


func _on_resume_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_quit_pressed() -> void:
	# TODO: eventual fa si salvare
	get_tree().quit()
