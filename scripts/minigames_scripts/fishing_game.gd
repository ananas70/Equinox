extends Control

@onready var catch_bar: ProgressBar = %CatchBar

var onCatch := false
var catchSpeed := 0.3
var catchingValue := 0.0

signal minigame_finished

func _physics_process(delta: float) -> void:
	if onCatch: catchingValue += catchSpeed
	else: catchingValue -= catchSpeed
	
	if catchingValue < 0.0: catchingValue = 0
	elif catchingValue >= 100: _game_end()
	
	catch_bar.value = catchingValue

func _game_end() -> void:
	var tween = get_tree().create_tween()
	
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "global_position", global_position + Vector2(0, 700), 0.5)
	
	await tween.finished

	end_minigame()


func _on_target_target_entered() -> void:
	onCatch = true

func _on_target_target_exited() -> void:
	onCatch = false
	
func end_minigame():
	print("send signal")
	emit_signal("minigame_finished")  # Anunță că s-a terminat
	await get_tree().process_frame
	queue_free()
