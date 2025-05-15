extends Control

var source_menu: Control = null
func _on_exit_button_pressed() -> void:
	if source_menu:
		source_menu.visible = true
	queue_free()
