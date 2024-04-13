extends CharacterBody3D

const SPEED := 25.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_down", "move_up")
	var vector := Vector3(direction.x, 0, -direction.y).normalized()
	move_and_collide(vector * SPEED * delta)
