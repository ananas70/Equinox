extends Node

func _on_key_collected():
	print("Afiseaza!!")
	get_node("../CollectedKey/Control/Sprite2D").visible = true  # Afișăm iconița
