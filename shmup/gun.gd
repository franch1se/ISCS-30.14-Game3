extends Node2D

@export var bullet_scene : PackedScene = load("res://player_bullet.tscn")
@onready var player = $"../CharacterBody2D"

var FIRE_RATE := 250.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		var bullet_count = round(FIRE_RATE * delta)
		for index in bullet_count:
			var bullet = bullet_scene.instantiate()
			bullet.position = player.position
			bullet.rotation = player.rotation
			add_child(bullet)
