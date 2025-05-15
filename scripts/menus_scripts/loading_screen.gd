extends CanvasLayer

@export_file("*.tscn") var next_scene_path: String

func _ready() -> void:
	ResourceLoader.load_threaded_request(next_scene_path)

func _process(delta: float) -> void:
	if ResourceLoader.load_threaded_get_status(next_scene_path) == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		await get_tree().create_timer(1.0).timeout

		var new_scene: PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
		var game = get_tree().root.get_node("Game")

		# curățăm meniurile din UI dacă urmează altceva
		for child in game.ui.get_children():
			child.queue_free()

		if new_scene:
			if next_scene_path.contains("menus"):
				game.show_menu(next_scene_path)
			else:
				game.load_level(next_scene_path)

		queue_free()
