extends CanvasLayer

signal minigame_finished_done


func _on_fishing_game_minigame_finished() -> void:
	emit_signal("minigame_finished_done") 
