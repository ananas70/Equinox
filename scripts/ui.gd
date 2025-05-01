extends CanvasLayer

var icons = {
	"autumn": {
		"gray": preload("res://assets/images/UI/autumn_gray.png"),
		"color": preload("res://assets/images/UI/autumn_color.png")
	},
	"winter": {
		"gray": preload("res://assets/images/UI/winter_gray.png"),
		"color": preload("res://assets/images/UI/winter_color.png")
	},
	"spring": {
		"gray": preload("res://assets/images/UI/spring_gray.png"),
		"color": preload("res://assets/images/UI/spring_color.png")
	},
	"summer": {
		"gray": preload("res://assets/images/UI/summer_gray.png"),
		"color": preload("res://assets/images/UI/summer_color.png")
	}
}

func _ready():
	# Inițializează toate iconițele ca alb-negru
	for season in icons.keys():
		var node_path = "PlayerInfoBox/" + season.capitalize() + "/" + season.capitalize()
		if has_node(node_path):
			var texrect = get_node(node_path)
			texrect.texture = icons[season]["gray"]
		else:
			print("⚠️ Nod negăsit pentru: ", node_path)

func activate_icon(season: String):
	if icons.has(season):
		var node_path = "PlayerInfoBox/" + season.capitalize() + "/" + season.capitalize()
		if has_node(node_path):
			var texrect = get_node(node_path)
			texrect.texture = icons[season]["color"]
		else:
			print("⚠️ Nod negăsit pentru: ", node_path)
