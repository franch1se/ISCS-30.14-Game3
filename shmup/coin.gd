extends Area2D

var speed = 80.0
var direction = 1
var value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = randi_range(-500, 500)
	position.y = -500
	value = 10

func _physics_process(delta: float) -> void:
	position.y += speed*delta
	rotation_degrees = 0

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
