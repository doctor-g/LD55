extends Area3D

signal hit_enemy

const SPEED := 5.0
const ACCELERATION := 0.1
const DISTANCE_PER_ORBITAL := 1.2

var angle := 0.0
var orbital := 1

var _connected := true
var _radius := 0.0
var _prev_position : Vector3
var _velocity : Vector3

func _physics_process(delta: float) -> void:
	if _connected:
		_prev_position = position
		angle = fmod(angle + SPEED / orbital * delta, TAU)
		_radius = move_toward(_radius, orbital * DISTANCE_PER_ORBITAL, ACCELERATION)
		position = Vector3(sin(angle), 0, cos(angle)) * _radius
	else:
		position += _velocity


func disconnect_from_nucleus() -> void:
	_connected = false
	_velocity = position - _prev_position
	$CollisionShape3D.disabled = true


func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		body.damage(self)
		hit_enemy.emit()
		queue_free()
	else:
		push_error("Unexpected collision with %s" % str(body))
