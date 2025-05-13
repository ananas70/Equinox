extends RigidBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered bridge")
	set_deferred("freeze", false)
	$Timer.start()

func _on_timer_timeout() -> void:
	queue_free()
