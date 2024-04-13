extends Area3D

const SPEED := 5.0

var angle := 0.0
var radius := 3.0

func _physics_process(delta: float) -> void:
	angle = fmod(angle + SPEED * delta, TAU)
	position.x = sin(angle)
	position.z = cos(angle)
