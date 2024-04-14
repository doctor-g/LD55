extends Area3D

const LERP_SPEED := 0.2

var target_position : Vector3


func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, target_position, LERP_SPEED)
	$Nucleus.rotate_y(TAU * delta)


func _on_body_entered(body: Node3D) -> void:
	# Only the player character can enter this body
	body.charge()
	queue_free()
