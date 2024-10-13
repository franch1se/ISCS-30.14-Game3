extends Area2D


@export var impact_scene : PackedScene = load("res://bullet_impact.tscn")
@export var deathParticle : PackedScene = load("res://particles.tscn")

@export var bullet_scene : PackedScene = load("res://enemy_bullet.tscn")
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("character")
@onready var sprite: Sprite2D = $Sprite2D
@onready var bullet_timer : Timer = $BulletTimer
@onready var healthbar: ProgressBar = $ProgressBar

@export var enemy_type = 1
@export var hp := 50
var speed := 80.0
var rot_speed := 3.0
var direction = 1

func _ready() -> void:
	bullet_timer.start()
	healthbar.max_value = hp
	healthbar.value = hp


func _physics_process(delta: float) -> void:
	position.x += speed*delta*direction
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
	player.add_kill(enemy_type)
	get_parent().enemy_killed.emit(enemy_type)

	queue_free()


func _on_timer_timeout() -> void:
	#print("BOOM BULLET")
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.rotation = sprite.rotation
		get_parent().add_child(bullet)
		bullet_timer.start()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
