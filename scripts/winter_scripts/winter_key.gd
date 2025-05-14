extends Area2D

signal key_collected  # Semnal pe care îl trimitem la colectare
	
func _on_body_entered(body):
	if body.name == "CharacterBody2D":  # Numele personajului
		print("Cheie!")
		emit_signal("key_collected")    # Trimite semnal
		queue_free()                    # Șterge cheia din scenă
