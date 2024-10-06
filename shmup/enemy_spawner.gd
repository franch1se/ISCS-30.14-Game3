extends Node2D

@export var enemy1 : PackedScene = load("res://enemy_1.tscn")
@onready var spawn_timer: Timer = $SpawnTimer

const SPAWN_X := 850.0
const SPAWN_Y := 480.0
const ENEMY_TYPES = 1

var enemy_i = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start()
	spawn(0)
	enemy_i = (enemy_i + 1) % ENEMY_TYPES


func spawn(enemy_index):
	if enemy_index == 0:
		for i in range(-1, 2, 2):
			var enemy1 = enemy1.instantiate()
			enemy1.position.x = SPAWN_X*i
			enemy1.position.y = randi_range(-SPAWN_Y, SPAWN_Y)
			enemy1.direction = i*-1
			add_child(enemy1)

func _on_spawn_timer_timeout() -> void:
	spawn(enemy_i)
	enemy_i = (enemy_i + 1) % ENEMY_TYPES

	
