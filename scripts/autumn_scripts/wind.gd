extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Entered wind")
	body.in_wind = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("Exited wind")
	body.in_wind = false
