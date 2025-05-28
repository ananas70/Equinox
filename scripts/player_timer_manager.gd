# PlayerTimerManager.gd
extends Node2D

@export var player_node_path: NodePath 
@export var max_timer_duration: float = 15.0
@export var timer_bar_offset: Vector2 = Vector2(0, 600)
# Calea către nodul "Game" (GameManager-ul tău)
@export var game_node_path: NodePath 

var current_timer_value: float
var player: CharacterBody2D
var game_node # Va ține referința la GameManager
var has_died_from_timer: bool = false

@onready var timer_bar: ProgressBar = $ExternalTimerBar
# Acest Timer este echivalentul celui din Killzone, care definește delay-ul înainte de reload
@onready var death_delay_timer: Timer = Timer.new() 

# --- ÎNCEPUT ADĂUGIRI PENTRU DOZATOARE ---
@onready var dozator1: Area2D = get_node_or_null("dozator1")
@onready var dozator2: Area2D = get_node_or_null("dozator2")
@onready var dozator3: Area2D = get_node_or_null("dozator3")
@onready var dozator4: Area2D = get_node_or_null("dozator4")
@onready var dozator5: Area2D = get_node_or_null("dozator5")

# --- SFÂRȘIT ADĂUGIRI PENTRU DOZATOARE ---

func _ready():
	death_delay_timer.one_shot = true
	# Setează wait_time similar cu cel pe care l-ai avea în Timer-ul din scena Killzone
	death_delay_timer.wait_time = 0.7 # Ajustează acest timp dacă e necesar
	death_delay_timer.timeout.connect(_on_death_delay_timer_timeout)
	add_child(death_delay_timer)

	# --- ÎNCEPUT ADĂUGIRI CONECTARE SEMNALE DOZATOARE ---
	if game_node_path and not game_node_path.is_empty():
		game_node = get_node_or_null(game_node_path)
	if not game_node and game_node_path and not game_node_path.is_empty():
		printerr(name + ": Nodul 'Game' (GameManager) nu a fost găsit la calea: " + str(game_node_path))
	# --- SFÂRȘIT ADĂUGIRI CONECTARE SEMNALE DOZATOARE ---
	
	if player_node_path:
		player = get_node_or_null(player_node_path)
	
	if not player:
		printerr("Player-ul nu a fost găsit! Asigură-te că player_node_path este corect.")
		set_process(false)
		if is_instance_valid(timer_bar): timer_bar.visible = false
		return
		
	if not player.is_in_group("player"):
		player.add_to_group("player")

	if is_instance_valid(timer_bar):
		timer_bar.max_value = max_timer_duration
		reset_countdown_timer()
	else:
		printerr("ExternalTimerBar nu a fost găsit!")

	# --- ÎNCEPUT ADĂUGIRI CONECTARE SEMNALE DOZATOARE (Continuare) ---
	# Conectăm fiecare dozator individual
	if dozator1:
		if not dozator1.body_entered.is_connected(_on_player_entered_dozator_zone):
			dozator1.body_entered.connect(_on_player_entered_dozator_zone)
			print(name + ": Conectat semnal pentru dozator1")
	else:
		printerr(name + ": Nodul 'dozator1' (Area2D) nu a fost găsit ca și copil!")

	if dozator2:
		if not dozator2.body_entered.is_connected(_on_player_entered_dozator_zone):
			dozator2.body_entered.connect(_on_player_entered_dozator_zone)
			print(name + ": Conectat semnal pentru dozator2")
	else:
		printerr(name + ": Nodul 'dozator2' (Area2D) nu a fost găsit ca și copil!")

	if dozator3:
		if not dozator3.body_entered.is_connected(_on_player_entered_dozator_zone):
			dozator3.body_entered.connect(_on_player_entered_dozator_zone)
			print(name + ": Conectat semnal pentru dozator3")
	else:
		printerr(name + ": Nodul 'dozator3' (Area2D) nu a fost găsit ca și copil!")

	if dozator4:
		if not dozator4.body_entered.is_connected(_on_player_entered_dozator_zone):
			dozator4.body_entered.connect(_on_player_entered_dozator_zone)
			print(name + ": Conectat semnal pentru dozator4")
	else:
		printerr(name + ": Nodul 'dozator4' (Area2D) nu a fost găsit ca și copil!")
	if dozator5:
		if not dozator4.body_entered.is_connected(_on_player_entered_dozator_zone):
			dozator5.body_entered.connect(_on_player_entered_dozator_zone)
			print(name + ": Conectat semnal pentru dozator4")
	else:
		printerr(name + ": Nodul 'dozator5' (Area2D) nu a fost găsit ca și copil!")
	# --- SFÂRȘIT ADĂUGIRI CONECTARE SEMNALE DOZATOARE (Continuare) ---

func _process(delta: float):
	if has_died_from_timer:
		return

	if not player or not is_instance_valid(player):
		if is_instance_valid(timer_bar): timer_bar.visible = false
		return

	if is_instance_valid(timer_bar):
		timer_bar.visible = true
		timer_bar.global_position = player.global_position + timer_bar_offset - Vector2(timer_bar.size.x / 2.5, 50)

		if current_timer_value > 0:
			current_timer_value -= delta
			timer_bar.value = current_timer_value
			if current_timer_value <= 0:
				current_timer_value = 0
				timer_bar.value = 0
				handle_timer_expired() # Aici se va apela logica de "moarte"
	else:
		set_process(false) 
		printerr("ExternalTimerBar a devenit invalid în _process.")


func reset_countdown_timer():
	current_timer_value = max_timer_duration
	has_died_from_timer = false
	Engine.time_scale = 1
	if is_instance_valid(timer_bar):
		timer_bar.value = current_timer_value
	# Dacă CollisionShape2D al player-ului a fost eliminat, ar trebui re-creat sau scena reîncărcată.
	# Deocamdată, la reset, nu facem nimic cu CollisionShape2D, presupunând că scena se va reîncărca oricum dacă moare.
	print("Timer (extern) resetat!")


func handle_timer_expired(): # Aceasta este echivalentul lui _on_body_entered din Killzone
	if has_died_from_timer or not player or not is_instance_valid(player):
		return # Nu face nimic dacă a murit deja sau player-ul nu e valid
	
	has_died_from_timer = true
	print("Timpul a expirat! Player-ul 'moare' (ca în Killzone).")
	
	Engine.time_scale = 0.5 # Încetinește timpul
	
	var collision_shape = player.get_node_or_null("CollisionShape2D")
	if collision_shape:
		collision_shape.queue_free()
		print("CollisionShape2D al player-ului a fost eliminat.")
	else:
		print("Nu s-a găsit CollisionShape2D pe player pentru a fi eliminat.")

	death_delay_timer.start() # Pornește timer-ul pentru delay înainte de reload


func _on_death_delay_timer_timeout() -> void: # Aceasta este echivalentul lui _on_timer_timeout din Killzone
	Engine.time_scale = 1
	var game = get_tree().root.get_node("Game")
	game.load_level(game.anotimpuri[game.current_season_index])

# NU MAI AVEM NEVOIE de trigger_timer_reset()
# Logica este acum direct în _on_player_entered_dozator_zone

# --- ÎNCEPUT ADĂUGARE FUNCȚIE CALLBACK PENTRU DOZATOARE ---
func _on_player_entered_dozator_zone(body: Node2D):
	# Putem obține numele nodului Area2D care a emis semnalul, dacă e nevoie,
	# prin semnalul însuși sau prin alte metode, dar pentru un reset simplu nu e necesar.
	# var area_node = # ... modalitate de a obține referința la Area2D care a emis, dacă e nevoie
	# print("Player a intrat în ", area_node.name)
	
	if body.is_in_group("player"): # Verifică dacă este player-ul
		print(name + ": Player a intrat într-o zonă de dozator. Timer resetat!")
		reset_countdown_timer() # Apelează direct funcția de reset
# --- SFÂRȘIT ADĂUGARE FUNCȚIE CALLBACK PENTRU DOZATOARE ---
