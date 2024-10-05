extends CharacterBody2D


@onready var crosshair = $"../Crosshair"

const MAX_SPEED = 600 # for both x and y
const NORMAL_SPEED = 30
const DEC_SPEED = 20

var hp = 100

func _ready() -> void:
	pass

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
