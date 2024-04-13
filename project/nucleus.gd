extends Node3D

@export var speed := 2.1

func _physics_process(delta: float) -> void:
	rotate_y(speed * delta)
