extends Node2D


var hp := 50

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	# Process hp
	if hp <= 0:
		# do some animations
		queue_free()
	
	# Process movement
	
	
	pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		hp -= 1
		area.queue_free()
	pass # Replace with function body.
