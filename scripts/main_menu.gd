extends Control


func _on_start_pressed() -> void:
	pass # Replace with function body.
#	inlocuieste mai jos cu scena care urmeaza
	#get_tree().change_scene_to_file()


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
