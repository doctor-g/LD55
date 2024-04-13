extends CPUParticles3D


func _ready() -> void:
	emitting = true
	$AudioStreamPlayer.pitch_scale = randfn(1.0, 0.05)


func _on_finished() -> void:
	queue_free()
