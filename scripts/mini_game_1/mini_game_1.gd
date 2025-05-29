extends Control
@onready var target_rect_1: TextureRect = $TargetRect1
@onready var target_rect_2: TextureRect = $TargetRect2
@onready var target_rect_3: TextureRect = $TargetRect3


func _on_button_pressed() -> void:
	var game = get_tree().root.get_node("Game")
	
	
	var correct = true
	
	if $TargetRect1.current_texture == null:
		correct = null
	if $TargetRect2.current_texture == null:
		correct = null
	if $TargetRect3.current_texture == null:
		correct = null
	
	if correct == true:
		# mergi la urmatorul anotimp
		game.goto_next_season()
	else:
		print("Mai încearcă!")
