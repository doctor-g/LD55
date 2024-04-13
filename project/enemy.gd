extends CharacterBody3D

@export var speed := 7.0
@export var target : Node3D


func _physics_process(delta: float) -> void:
	if target != null:
		var direction := (target.global_position - global_position).normalized()
		var collision := move_and_collide(direction * speed * delta)
		if collision != null and collision.get_collider() == target:
			target.damage()
			queue_free()


func damage() -> void:
	queue_free()
