extends Node2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("character")


func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.hp <= 0:
		visible = true
