extends Node2D


@export var impact_scene : PackedScene = load("res://bullet_impact.tscn")

var hp := 50

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	# Process hp
	if hp <= 0:
		# do some animations
		queue_free()
	
	# Process movement
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		print("Enemy hp: ", hp)
		hp -= 1
		var impact = impact_scene.instantiate()
		impact.position = area.get_child(0).position
		print("AREA POS: ", area.get_child(0).position)
		add_child(impact)
		area.queue_free()
		

func _on_hitbox_body_entered(body: Node2D) -> void:
	hp -= 1
	
