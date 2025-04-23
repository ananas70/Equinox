extends Node
# e pentru functii generice (ex format time)


# o folosim ca sa incarcam loading screen-ul inainte
func load_screen_to_scene(target: String) -> void:
	var loading_screen = preload("res://scenes/menus/loading_screen.tscn").instantiate()
	loading_screen.next_scene_path = target
	get_tree().current_scene.add_child(loading_screen)
