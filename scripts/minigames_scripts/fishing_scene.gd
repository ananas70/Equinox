extends Node2D

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	$GoblinPlayer.call_deferred("_start_mini_game")


func _on_goblin_player_close_scene() -> void:
	get_node("/root/Game").goto_next_season()
