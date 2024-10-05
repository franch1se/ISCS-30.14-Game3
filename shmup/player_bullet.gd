extends Area2D


var SPEED := 1750.0

func _physics_process(delta: float) -> void:
	var distance := SPEED * delta
	var motion := -transform.y * SPEED * delta
	position += motion
	print("BUL POS: ", position)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
