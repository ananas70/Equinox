extends Control

var previous_scene_path = ""

func _on_exit_button_pressed() -> void:
	if previous_scene_path != "":
		get_tree().change_scene_to_file(previous_scene_path)
	else:
		get_tree().quit()  # fallback, nu ar trebui să ajungi aici
