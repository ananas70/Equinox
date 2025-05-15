extends CanvasLayer
@onready var image = $Image
@onready var text = $Label
@onready var timer = $Timer
@onready var text_switch_timer: Timer = $TextSwitchTimer

var slides = [
	{ 
		"image": "res://assets/images/glodenor-at-night.png",
	 	"text1": "Once upon a time, in a kingdom where peace and love bloomed in every corner",
		"text2": "in a world where nature and joy lived hand in hand",
		"text_1_duration": 5.0,
		"zoom": true,
		"duration": 10.0 
	},
	{ 
		"image": "res://assets/images/glodenor-at-night.png",
		"text": "But wait, turn on the lights!",
		"zoom": false,
		"duration": 3.0
	},
	{ 
		"image": "res://assets/images/glodenor-at-day.png",
		"text": "Ah, much better!",
		"zoom": false,
		"duration": 3.0
	},
	{ 
		"image": "res://assets/images/glodenor-at-day.png",
		"text": "In this wonderful kingdom kingdom, there ruled a beautiful and kind-hearted princess.",
		"zoom": true,
		"duration": 5.0
	},
	{ 
		"image": "res://assets/images/princess_diana/princess_in_the_caste.png",
		"text": "Her name was Princess Diana.",
		"zoom": false,
		"duration": 3.0
	},
	{ 
		"image": "res://assets/images/princess_diana/princess_in_the_caste.png",
		"text": "She had taken the throne of Glodenor at just seventeen, and her reign became known as the fairest in memory.",
		"zoom": true,
		"duration": 8.0
	},
	{ 
		"image": "res://assets/images/princess_diana/princess_and_crowd.png",
		"text": "People called her “The Lawful Diana”",
		"zoom": true,
		"duration": 5.0
	},
	{ 
		"image": "res://assets/images/princess_diana/princess_and_animals.png",
		"text": "...loved by villagers, animals, and nature alike for her pure heart.",
		"zoom": true,
		"duration": 6.0
	},
	{ 
		"image": "res://assets/images/glodenor_and_seasons.png",
		"text1": "Yet beyond the borders of Glodenor, in the enchanted lands surrounding the kingdom...",
		"text2": "...the seasons themselves were in a constant dance, shifting and changing in ways that no one fully understood.",
		"text_1_duration": 7.0,
		"zoom": true,
		"duration": 14.0
	},
	{ 
		"image": "res://assets/images/yryneus_malus/yryneus_outside_cave.png",
		"text": "But Glodenor’s happiness was about to be disturbed by a solitary, wicked dragon named Yryneus Malus.",
		"zoom": true,
		"duration": 7.0
	},
	{ 
		"image": "res://assets/images/yryneus_malus/yryneus_cave_gold.png",
		"text": "Far away in his cavern, he guarded a vast treasure—but no amount of gold could ease the emptiness in his heart.",
		"zoom": true,
		"duration": 7.0
	},
	{ 
		"image": "res://assets/images/yryneus_malus/yryneus_invitation.png",
		"text1": "One day, a wandering letter found its way to Yryneus: an invitation to Princess Diana’s 22nd birthday.",
		"text2": "It included her portrait, and the moment he saw her, something awoke in him - love.",
		"text_1_duration": 6.0,
		"zoom": true,
		"duration": 12.0
	},
	{ 
		"image": "res://assets/images/yryneus_malus/yryneus_flies_away_to_diana.png",
		"text": "Determined to win her heart, Yryneus left his treasure behind and set off toward Glodenor.",
		"zoom": true,
		"duration": 7.0
	},
	{ 
		"image": "res://assets/images/diana_and_yryneus/yryneus_proposes.png",
		"text1": "After a long journey, Yryneus reached the gates during Diana’s grand celebration.",
		"text2": "He bowed before her, offering riches beyond imagination and asking for her hand.",
		"text_1_duration": 6.0,
		"zoom": true,
		"duration": 12.0
	},
	{ 
		"image": "res://assets/images/diana_and_yryneus/diana_refuses_yryneus.png",
		"text1": "“Great Yryneus,” she said, “I vowed long ago to give my heart only to true, selfless love.”",
		"text2": "“Forgive me, but I cannot be yours.”",
		"text_1_duration": 6.0,
		"zoom": true,
		"duration": 12.0
	},
	{ 
		"image": "res://assets/images/diana_and_yryneus/yryneus_kidnaps_diana.png",
		"text1": "Heartbroken and enraged, Yryneus roared, seized her in his claws, and vanished into the night.",
		"text2": "He flew her back to his cavern and declared:",
		"text_1_duration": 6.0,
		"zoom": true,
		"duration": 12.0
	},
	{ 
		"image": "res://assets/images/diana_and_yryneus/yryneus_threatens_diana.png",
		"text": "“If you won’t be mine, then here you’ll stay—forever a prisoner of your own choice.”",
		"zoom": true,
		"duration": 6.0
	},
	{ 
		"image": "res://assets/images/the_frog_man/frog_baby_saves_bat.png",
		"text": "Long before Diana’s capture, there lived a man who once saved a bat from a wicked witch.",
		"zoom": true,
		"duration": 7.0
	},
	{ 
		"image": "res://assets/images/the_frog_man/the_frog_sad_home.png",
		"text1": "Enraged, she disfigured him and cursed him to wear a frog-shaped mask for life.",
		"text2": "Nevertheless, his heart remained brave and kind. From then on, he was known only as the Frog.",
		"text_1_duration": 6.0,
		"zoom": true,
		"duration": 12.0
	},
	{ 
		"image": "res://assets/images/the_frog_man/the_frog_leaves_glodenor.png",
		"text1": "Upon hearing of the princess’s abduction, something stirred within the Frog.",
		"text2": "He sold everything he had and set out, armed and determined to rescue her from the dragon’s grasp.",
		"text_1_duration": 6.0,
		"zoom": true,
		"duration": 12.0
	},
	{ 
		"image": "res://assets/images/the_frog_man/the_frog_leaves_landscape.png",
		"text1": "To rescue Princess Diana, the frog had to cross through the four seasons of the enchanted lands.",
		"text2": "Each season held its own trials, testing his courage, heart, and determination.",
		"text_1_duration": 6.0,
		"zoom": true,
		"duration": 12.0
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
