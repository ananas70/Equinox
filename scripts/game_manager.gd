extends Node

var chest_opened := false

func _on_key_collected():
	print("Afiseaza!!")
	# Afisam iconita -> cheia a fost preluata
	var icon_key = get_node("../CollectedKey/Control/Sprite2D")
	icon_key.visible = true
