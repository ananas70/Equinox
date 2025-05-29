extends Control


func _on_start_pressed() -> void:
	var game = get_tree().root.get_node("Game")

	if game.load_game():
		# Dacă există un joc salvat, îl reîncarcă
		game.load_screen_to_scene(game.anotimpuri[game.current_season_index])
	else:
		if Globals.intro_seen:
			game.current_season_index = 0
			game.save_game()  # salvăm startul de la anotimpul 0
			game.load_screen_to_scene(game.anotimpuri[0])
		else:
			Globals.intro_seen = true
			game.current_season_index = 0
			game.save_game()  # salvăm înainte de intro
			game.load_screen_to_scene("res://scenes/intro_cut_scene.tscn")



func _on_options_pressed() -> void:
	var game = get_tree().root.get_node("Game")
	var options_menu = preload("res://scenes/menus/options_menu.tscn").instantiate()
	options_menu.source_menu = self
	game.ui.add_child(options_menu)
	self.visible = false  # ascunde main_menu temporar
	
func _on_exit_pressed() -> void:
	get_tree().quit()
