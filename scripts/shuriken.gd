extends Area2D

@export var speed := 500
@export var direction := Vector2.RIGHT

func _ready():
	$AnimatedSprite2D.play("fly")
	$Timer.start()
	connect("body_entered", Callable(self, "_on_hit"))

func _physics_process(delta):
	position += direction * speed * delta

func _on_hit(body):
	if body.is_in_group("enemy"):
		speed = 0  # oprește mișcarea
		body.take_damage()
		
		if direction.x > 0:
			$AnimatedSprite2D.position.x = 11  # spre dreapta
		else:
			$AnimatedSprite2D.position.x = -11  # spre stânga
			
		$AnimatedSprite2D.play("damage")
		await $AnimatedSprite2D.animation_finished
		
	queue_free()  # distruge shurikenul la contact

func _on_Timer_timeout():
	queue_free()  # distruge dacă nu lovește nimic
