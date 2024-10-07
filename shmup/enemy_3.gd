extends Area2D


@export var impact_scene : PackedScene = load("res://bullet_impact.tscn")
@export var deathParticle : PackedScene = load("res://particles.tscn")
@onready var explosionSFX = $explosionSFX

@export var bullet_scene : PackedScene = load("res://enemy_bullet.tscn")
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("character")
@onready var sprite: Sprite2D = $Sprite2D
@onready var healthbar: ProgressBar = $ProgressBar


@export var hp := 50
var speed := 200.0
var rot_speed := 10.0
var bullet_count := 18
var direction = 1

func _ready() -> void:
	healthbar.max_value = hp
	healthbar.value = hp

func _physics_process(delta: float) -> void:
	position.x += speed*delta*direction
	position.y -= speed*delta*direction
	sprite.rotation += rot_speed*delta
	
	# Process hp
	if hp <= 0:
		# do some animations
		Global.camera.screen_shake(3, 3, 0.05)
		kill()
	
	# Process movement
	
	healthbar.value = hp
	healthbar.rotation_degrees = 0

func kill():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.get_child(0).emitting = true
	get_tree().current_scene.add_child(_particle)
	explosionSFX.play()
	player.add_kill()
	
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
