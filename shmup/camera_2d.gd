extends Camera2D

var startshake = false
var shakeintensity = 0.0
var shakedampening = 0.0

@onready var shaketime = $ShakeTime

func _ready():
	Global.camera = self
	
func _process(delta):
	if startshake == true:
		offset.x = randf_range(-2.0, 2.0) * shakeintensity
		offset.y = randf_range(-2.0, 2.0) * shakeintensity
		shakeintensity = lerpf(shakeintensity, 0.0 , shakedampening)
	else:
		offset = Vector2(0,0)
		
func screen_shake(intensity, duration, dampening):
	shakeintensity = intensity
	shaketime.wait_time = duration
	shakedampening = dampening
	startshake = true

func _on_shake_time_timeout() -> void:
	startshake = false # Replace with function body.
