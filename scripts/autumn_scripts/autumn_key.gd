extends Area2D

signal key_collected  # Semnal pe care îl trimitem la colectare

@onready var Sparkle = $Sparkle
	
func _on_body_entered(body):
	if body.name == "CharacterBody2D":  # Numele personajului
		# Dezactivează coliziunea imediat, ca să nu se retrigeze
		$CollisionShape2D.disabled = true

		# Pornește animatia și ascunde cheia
		$AnimatedSprite2D.visible = false  # ascunde cheia vizual
		emit_signal("key_collected")
		get_node("../AutumnChest").has_key = true
		
		Sparkle.visible = true
		Sparkle.play("sparkle")
		
		# Așteaptă un frame ca să fii sigur ca animatia incepe
		await get_tree().process_frame
		# Așteaptă finalul animatiei
		await Sparkle.animation_finished
		queue_free()
