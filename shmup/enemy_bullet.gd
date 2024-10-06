extends Area2D

@export var impact_scene : PackedScene = load("res://bullet_impact.tscn")

var SPEED := 500.0

func _physics_process(delta: float) -> void:
	var motion := -transform.y * SPEED * delta
	position += motion

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var impact = impact_scene.instantiate()
		impact.global_position = global_position
		impact.rotation = rotation - deg_to_rad(20)
		get_parent().add_child(impact)
		area.get_parent().hp -= 1
		queue_free()
