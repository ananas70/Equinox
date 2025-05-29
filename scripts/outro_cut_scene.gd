extends CanvasLayer
@onready var image = $Image
@onready var text = $Label
@onready var timer = $Timer
@onready var text_switch_timer: Timer = $TextSwitchTimer

var slides = [
		{
		"image": "res://assets/images/ingredients_yryneuys.png",
	 	"text": "By collecting the four magical ingredients, The Frog managed to brew a potion that put the dragon into a deep sleep.",
		"zoom": true,
		"duration": 7.0
	},
	{
		"image": "res://assets/images/frog_and_diana/frog_rescues_diana.png",
	 	"text": "With courage in his heart, he entered the dark cave and bravely rescued Diana.",
		"zoom": true,
		"duration": 5.8
	},
	{ 
		"image": "res://assets/images/frog_and_diana/diana_wants_to_unmask_frog.png",
		"text1": "When they arrived at the gates of the kingdom, Diana turned to him and gently asked",
		"text2": "“Please, take off your mask — I want to see your true face.”",
		"text_1_duration": 4.5,
		"zoom": true,
		"duration": 8.3
	},
	{
		"image": "res://assets/images/frog_and_diana/diana_wants_to_unmask_frog2.png",
	 	"text1": "Ashamed, the Frog hesitated. “I cannot,” he said, “I carry a hideous flaw.”",
		"text2": "But Diana insisted, saying, “What matters to me is your soul, not your appearance.”",
		"text_1_duration": 6.5,
		"zoom": true,
		"duration": 12.0 
	},
	{
		"image": "res://assets/images/frog_and_diana/diana_falls_in_love_with_frog.png",
	 	"text1": "With sorrow in his heart, the Frog slowly removed his mask.",
		"text2": "To his surprise, he found not fear or disgust in Diana’s eyes — but love.",
		"text_1_duration": 3.0,
		"zoom": true,
		"duration": 8.5 
	},
	{
		"image": "res://assets/images/frog_and_diana/diana_confesses_love_to_frog.png",
	 	"text": "She confessed her feelings to him, for his courage, his kindness, and everything good he had shown her.",
		"zoom": true,
		"duration": 6.5 
	},
	{
		"image": "res://assets/images/frog_and_diana/diana_and_frog_get_married.png",
	 	"text": "A few months later, Diana and the Frog were wed in a joyous celebration, surrounded by the cheers of their people.",
		"zoom": true,
		"duration": 7.5 
	},
	{
		"image": "res://assets/images/glodenor_celebrate.png",
	 	"text": "And so, the kingdom of Glodenor found happiness once more, and its people lived in peace and love for the rest of their days.",
		"zoom": true,
		"duration": 8.5 
	}
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
		game.load_screen_to_scene("res://scenes/menus/victory_menu.tscn")


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
	game.load_screen_to_scene("res://scenes/menus/victory_menu.tscn")

	# Distrugi această scenă dacă e nevoie
	queue_free()
