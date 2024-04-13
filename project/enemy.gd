extends CharacterBody3D

const ACCELERATION := 3.0
const CHARGE_DROP_DISTANCE := 3.0

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


func damage(cause : Node3D) -> void:
	var charge := preload("res://charge.tscn").instantiate()
	add_sibling(charge)
	charge.global_position = global_position
	charge.target_position = global_position + (global_position - cause.global_position).normalized() * CHARGE_DROP_DISTANCE
	queue_free()
