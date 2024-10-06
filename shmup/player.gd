extends CharacterBody2D


@onready var crosshair = $"../Crosshair"

const MAX_SPEED = 600 # for both x and y
const NORMAL_SPEED = 30
const DEC_SPEED = 20
const BORDER_LIMIT = 470

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
	
	var collide = move_and_collide(velocity*delta)
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
		hp -=10
		print(hp)

func check_hp():
	if hp <= 0:
		queue_free()
