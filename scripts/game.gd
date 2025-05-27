extends Node2D
@onready var level: Node2D = $Level
@onready var ui: CanvasLayer = $UI

var anotimpuri = [
	"res://scenes/autumn_scenes/autumn_scene.tscn",
	"res://scenes/winter_scenes/winter_scene.tscn",
	"res://scenes/spring_scenes/spring_level.tscn",
	"res://scenes/summer_scenes/summer.tscn"
]
var current_season_index = 0

func goto_next_season():
	current_season_index += 1
	if current_season_index >= anotimpuri.size():
		current_season_index = 0  # sau încheie jocul

	load_screen_to_scene(anotimpuri[current_season_index])


# Încarcă o scenă de joc / intro / nivel
func load_level(path: String):
	for child in level.get_children():
		child.queue_free()

	var scene = load(path).instantiate()
	level.add_child(scene)

# Încarcă un meniu peste UI (main menu, pause etc.)
func show_menu(path: String):
	var menu = load(path).instantiate()
	ui.add_child(menu)

# Încarcă un ecran de loading care apoi trece la target
func load_screen_to_scene(target: String):
	# Ascunde toate CanvasLayer-urile din scena curentă de nivel (Level)
	for child in level.get_children():
		child.queue_free()
		
	var loading_screen = preload("res://scenes/menus/loading_screen.tscn").instantiate()
	loading_screen.next_scene_path = target
	get_tree().current_scene.add_child(loading_screen)

# Flow-ul principal (de apelat la început)
func start_game_flow():
	load_screen_to_scene("res://scenes/menus/main_menu.tscn")

# Eventual: trece direct la un anotimp
func start_anotimp(anotimp: String):
	#load_screen_to_scene("res://scenes/anotimpuri/%s. tscn" % anotimp)
	pass

# Activează Pause Menu
func show_pause_menu():
	if get_tree().paused:
		return  # deja e activ

	get_tree().paused = true

	var pause_menu = preload("res://scenes/menus/pause_menu.tscn").instantiate()
	pause_menu.name = "PauseMenu"
	ui.add_child(pause_menu)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		show_pause_menu()
		
		
	# DEBUG: trece la anotimpul următor cu tasta A
	if event.is_action_pressed("debug_next_season"):
		goto_next_season()
		
func _ready():
	start_game_flow()
