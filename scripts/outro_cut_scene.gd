extends CanvasLayer
@onready var image = $Image
@onready var text = $Label
@onready var timer = $Timer
@onready var text_switch_timer: Timer = $TextSwitchTimer

var slides = [
	{
		"image": "res://assets/images/frog_and_diana/frog_rescues_diana.png",
	 	"text": "The Frog bravely rescued Diana from the dragon’s cave.",
		"zoom": true,
		"duration": 8.5 
	},
	{ 
		"image": "res://assets/images/frog_and_diana/diana_wants_to_unmask_frog.png",
		"text1": "When they arrived at the gates of the kingdom, Diana turned to him and gently asked",
		"text2": "“Please, take off your mask — I want to see your true face.”",
		"text_1_duration": 5.0,
		"zoom": false,
		"duration": 10.0
	},
	
	{
		"image": "res://assets/images/frog_and_diana/diana_wants_to_unmask_frog2.png",
	 	"text1": "Ashamed, the Frog hesitated. “I cannot,” he said, “I carry a hideous flaw.”",
		"text2": "But Diana insisted, saying, “What matters to me is your soul, not your appearance.”",
		"text_1_duration": 5.0,
		"zoom": true,
		"duration": 8.5 
	},
	{
		"image": "res://assets/images/frog_and_diana/diana_wants_to_unmask_frog2.png",
	 	"text1": "Ashamed, the Frog hesitated. “I cannot,” he said, “I carry a hideous flaw.”",
		"text2": "But Diana insisted, saying, “What matters to me is your soul, not your appearance.”",
		"text_1_duration": 5.0,
		"zoom": true,
		"duration": 8.5 
	},
]

var current_slide = 0

func _ready():
	show_slide(current_slide)

func show_slide(index):
	text_switch_timer.stop()
	var data = slides[index]
	#var viewport_size = get_viewport().get_visible_rect().size
	#var texture_size = image.texture.get_size()
	## Calculează cel mai mic factor de scalare care încadrează imaginea complet
	#var scale_factor = min(viewport_size.x / texture_size.x, viewport_size.y / texture_size.y)
	#

	image.texture = load(data.image)
	image.centered = true
	image.scale = Vector2(1, 1)
	image.position = get_viewport().get_visible_rect().size / 2
	
	if data.has("text1"):
		text.text = data.get("text1", "")
	elif data.has("text"):
		text.text = data.get("text", "")
	else:
		text.text = ""
	var duration = data.get("duration", 6.0)
	var should_zoom = data.get("zoom", true)

	# Zoom efect
	if should_zoom:
		print("ZOOM slide", index, "for", duration, "sec")
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(image, "scale", Vector2(1.1, 1.1), duration)
		#call_deferred("start_slide_timer", duration)

	# Start slide timer
	timer.start(duration)
	if data.has("text2"):

	# Dacă are al doilea text
		var text_delay = data.get("text_1_duration", duration / 2)
		text_switch_timer.start(text_delay)
	
func _on_timer_timeout() -> void:
	current_slide += 1
	if current_slide < slides.size():
		show_slide(current_slide)
	else:
		var game = get_tree().root.get_node("Game")
		game.load_screen_to_scene("res://scenes/autumn_scenes/autumn_scene.tscn")


func _on_text_switch_timer_timeout() -> void:
	var data = slides[current_slide]
	text.text = data.get("text2", "")
	
func start_slide_timer(duration):
	timer.start(duration)
	
func _on_skip_button_pressed() -> void:
	skip_cutscene()

func skip_cutscene():
	timer.stop()
	text_switch_timer.stop()
	
	# Poți adăuga și un fade-out, dacă vrei tranziție frumoasă

	var game = get_tree().root.get_node("Game")
	game.load_screen_to_scene("res://scenes/autumn_scenes/autumn_scene.tscn")

	# Distrugi această scenă dacă e nevoie
	queue_free()
