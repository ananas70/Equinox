extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var tile_marker = $AnimatedSprite2D/tileMarker
@onready var waiting: Sprite2D = $Waiting
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var waiting_timer: Timer = $WaitingTimer

const SPEED = 100.0

var fishing = true

func _ready() -> void:
	waiting.visible = false

func _physics_process(delta):
	if fishing:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("fishing_end")

func _get_tile_data():
	var tileMap = get_parent().find_child("TileMap")
	var searchPosition = tileMap.local_to_map(tile_marker.global_position)
	var data = tileMap.get_cell_tile_data(0,searchPosition)

	if data: return data.get_custom_data("type")

func _start_mini_game():
	#get_tree().paused = true
	PhysicsServer2D.set_active(true)
	
	var fishing_game = preload("res://scenes/minigames_scenes/fishing_minigame.tscn").instantiate()
	await get_tree().process_frame
	get_tree().current_scene.add_child(fishing_game)

func _on_fishing_minigame_minigame_finished_done() -> void:
	print("Mini-game done!")
	fishing = false
	
