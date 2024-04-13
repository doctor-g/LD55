extends Area3D

const SPEED := 5.0
const ACCELERATION := 0.1
const DISTANCE_PER_ORBITAL := 1.2

var angle := 0.0
var orbital := 1

var _radius := 0.0


func _physics_process(delta: float) -> void:
	angle = fmod(angle + SPEED / orbital * delta, TAU)
	_radius = move_toward(_radius, orbital * DISTANCE_PER_ORBITAL, ACCELERATION)
	position = Vector3(sin(angle), 0, cos(angle)) * _radius


func _on_body_entered(body: Node3D) -> void:
	# Only enemies can trigger this, so damage them and remove the satellite
	body.damage(self)
	queue_free()
