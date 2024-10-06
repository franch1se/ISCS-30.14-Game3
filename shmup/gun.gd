extends Node2D

@export var bullet_scene : PackedScene = load("res://player_bullet.tscn")
@onready var player = $"../CharacterBody2D"
@onready var laserSFX = $"../laserSFX"

var FIRE_RATE := 50.0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.position = player.position
		bullet.rotation = player.rotation
		add_child(bullet)
		laserSFX.play()
