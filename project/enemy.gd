class_name Enemy extends CharacterBody3D

const DELTA_TOWARD := 3.0
const CHARGE_DROP_DISTANCE := 3.0
const ROTATION_SPEED := -0.7 * TAU

## Speed increase per second
const ACCELERATION := 0.5

@export var speed := 7.0
@export var target : Node3D

var _direction := Vector3.ZERO

func _physics_process(delta: float) -> void:
	rotate_y(ROTATION_SPEED * delta)
	
	speed += ACCELERATION * delta
	
	if target != null and target.alive:
		var new_direction := (target.global_position - global_position).normalized()
		
		_direction = _direction.move_toward(new_direction, DELTA_TOWARD * delta)
		
		var collision := move_and_collide(_direction * speed * delta)
		if collision != null and collision.get_collider() == target:
			target.damage()
			
			var explosion := preload("res://enemy_explosion.tscn").instantiate()
			add_sibling(explosion)
			explosion.global_position = global_position
			
			queue_free()


func damage(cause : Node3D) -> void:
	var charge := preload("res://charge.tscn").instantiate()
	add_sibling(charge)
	charge.global_position = global_position
	charge.target_position = global_position + (global_position - cause.global_position).normalized() * CHARGE_DROP_DISTANCE
	
	var explosion := preload("res://enemy_explosion.tscn").instantiate()
	add_sibling(explosion)
	explosion.global_position = global_position
	
	queue_free()
