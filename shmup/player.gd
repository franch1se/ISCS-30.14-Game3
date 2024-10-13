extends CharacterBody2D


@onready var crosshair = $"../Crosshair"
@onready var healthbar = get_tree().get_first_node_in_group("healthbar")
@export var deathParticle : PackedScene = load("res://particles.tscn")
@onready var spawner = get_tree().get_first_node_in_group("spawner")

const MAX_SPEED = 600 # for both x and y
const NORMAL_SPEED = 30
const DEC_SPEED = 20
const BORDER_LIMIT = 470

const max_hp = 100
var hp = max_hp
var kill_count = 0
var score = 0

func _ready() -> void:
	kill_count = 0
	healthbar.value = hp
	healthbar.max_value = max_hp

func _physics_process(delta: float) -> void:
	# Handle movement
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	move(direction_x, direction_y)
	
	# Handle aim
	var mouse_coor = get_global_mouse_position()
	rotation = atan2(mouse_coor.y - position.y, mouse_coor.x - position.x) + deg_to_rad(90)
	crosshair.position = mouse_coor
	crosshair.rotation = rotation
	
	move_and_slide()
	check_hp()
	
	position.x = clamp(position.x, -BORDER_LIMIT, BORDER_LIMIT)
	position.y = clamp(position.y, -BORDER_LIMIT, BORDER_LIMIT)
	
func move(dx, dy):
	if dx:
		velocity.x = clamp(velocity.x + dx*NORMAL_SPEED, -MAX_SPEED, MAX_SPEED)
	elif velocity.x > 0:
		velocity.x = max(velocity.x - DEC_SPEED, 0)
	elif velocity.x < 0:
		velocity.x = min(velocity.x + DEC_SPEED, 0)
	
	if dy:
		velocity.y = clamp(velocity.y + dy*NORMAL_SPEED, -MAX_SPEED, MAX_SPEED)
	elif velocity.y > 0:
		velocity.y = max(velocity.y - DEC_SPEED, 0)
	elif velocity.y < 0:
		velocity.y = min(velocity.y + DEC_SPEED, 0)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		hp -= 5
		area.hp -= 10
	if area.is_in_group("enemy_bullet"):
		hp -= 5
	if area.is_in_group("coins"):
		if hp < max_hp: 
			hp = min(max_hp, hp + 10)
			area.queue_free()
	healthbar.value = hp

func check_hp():
	if hp <= 0:
		var _particle = deathParticle.instantiate()
		_particle.position = global_position
		_particle.rotation = global_rotation
		_particle.get_child(0).emitting = true
		get_tree().current_scene.add_child(_particle)
		queue_free()
		
func add_kill(enemy_type):
	kill_count += 1
	if kill_count%3 == 0:
		spawner.spawn_coin()
	
	if enemy_type == 0:
		score += 100*spawner.difficulty
	elif enemy_type == 1:
		score += 150*spawner.difficulty
	elif enemy_type == 2:
		score += 200*spawner.difficulty
