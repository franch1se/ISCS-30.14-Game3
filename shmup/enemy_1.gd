extends Area2D


@export var impact_scene : PackedScene = load("res://bullet_impact.tscn")
@export var deathParticle : PackedScene = load("res://particles.tscn")

var hp := 1

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position.x -= delta*5 # to be deleted
	
	# Process hp
	if hp <= 0:
		# do some animations
		kill()
	
	# Process movement

func kill():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.get_child(0).emitting = true
	get_tree().current_scene.add_child(_particle)
	
	queue_free()

