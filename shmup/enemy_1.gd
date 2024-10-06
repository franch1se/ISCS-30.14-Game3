extends Node2D


@export var impact_scene : PackedScene = load("res://bullet_impact.tscn")
@export var deathParticle : PackedScene = load("res://particles.tscn")

var hp := 1

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	# Process hp
	if hp <= 0:
		# do some animations
		kill()
	
	# Process movement
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		#print("Enemy hp: ", hp)
		hp -= 1
		var impact = impact_scene.instantiate()
		impact.position = area.get_child(0).position
		#print("AREA POS: ", area.get_child(0).position)
		add_child(impact)
		area.queue_free()
		

func _on_hitbox_body_entered(body: Node2D) -> void:
	hp -= 1
	

func kill():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.get_child(0).emitting = true
	get_tree().current_scene.add_child(_particle)
	
	queue_free()
