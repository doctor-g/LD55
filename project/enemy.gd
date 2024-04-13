extends CharacterBody3D

const ACCELERATION := 3.0

@export var speed := 7.0
@export var target : Node3D

var _direction := Vector3.ZERO

func _physics_process(delta: float) -> void:
	if target != null:
		var new_direction := (target.global_position - global_position).normalized()
		
		_direction = _direction.move_toward(new_direction, ACCELERATION * delta)
		
		var collision := move_and_collide(_direction * speed * delta)
		if collision != null and collision.get_collider() == target:
			target.damage()
			queue_free()


func damage() -> void:
	queue_free()
