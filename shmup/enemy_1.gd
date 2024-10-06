extends Area2D


var hp := 50

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position.x -= delta*5 # to be deleted
	
	# Process hp
	if hp <= 0:
		queue_free()
	
	# Process movement
