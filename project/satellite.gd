extends Area3D

const SPEED := 5.0

var angle := 0.0
var radius := 3.0

func _physics_process(delta: float) -> void:
	angle = fmod(angle + SPEED * delta, TAU)
	position.x = sin(angle)
	position.z = cos(angle)


func _on_body_entered(body: Node3D) -> void:
	# Only enemies can trigger this, so damage them and remove the satellite
	body.damage(self)
	queue_free()
