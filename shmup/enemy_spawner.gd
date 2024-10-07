extends Node2D

@export var enemy1 : PackedScene = load("res://enemy_1.tscn")
@export var enemy2 : PackedScene = load("res://enemy_2.tscn")
@export var enemy3 : PackedScene = load("res://enemy_3.tscn")
@export var coins: PackedScene = load("res://coins.tscn")
@onready var spawn_timer: Timer = $SpawnTimer

const SPAWN_X := 850.0
const SPAWN_Y := 480.0
const ENEMY_TYPES = 3

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
	if enemy_index == 1:
		var enemy2 = enemy2.instantiate()
		enemy2.position.x = SPAWN_X
		enemy2.position.y = randi_range(-SPAWN_Y, SPAWN_Y)
		enemy2.direction = -1
		add_child(enemy2)
	if enemy_index == 2:
		for i in range(2):
			var enemy3 = enemy3.instantiate()
			if i%2 == 0:
				enemy3.position.x = SPAWN_X
				enemy3.position.y = -450
				enemy3.direction = -1
			else:
				enemy3.position.x = -SPAWN_X
				enemy3.position.y = 450
				enemy3.direction = 1
			add_child(enemy3)

func spawn_coin():
	var new_coin = coins.instantiate()
	add_child(new_coin)

func _on_spawn_timer_timeout() -> void:
	spawn(enemy_i)
	enemy_i = (enemy_i + 1) % ENEMY_TYPES
