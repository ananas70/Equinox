extends Area2D

@export_node_path("Area2D") var target_portal: NodePath
@export var cooldown_time: float = 0.8

var can_teleport: bool = true

func _on_body_entered(body: Node) -> void:
	if not can_teleport:
		return
	if body.is_in_group("player"):
		print("→ Path către target_portal:", target_portal)
		var target = get_node_or_null(target_portal)
		if not target:
			print("‼️ Target portal not found!")
			return
		target.can_teleport = false
		body.set_deferred("global_position", target.global_position)
		await get_tree().create_timer(cooldown_time).timeout
		target.can_teleport = true
