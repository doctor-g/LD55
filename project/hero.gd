extends CharacterBody3D

const SPEED := 25.0
const SATELLITE_SCENE := preload("res://satellite.tscn")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_down", "move_up")
	var vector := Vector3(direction.x, 0, -direction.y).normalized()
	move_and_collide(vector * SPEED * delta)
	
	if Input.is_action_just_pressed("summon"):
		# Summon a pair for fun
		var satellite_1 := SATELLITE_SCENE.instantiate()
		add_child(satellite_1)
		var satellite_2 := SATELLITE_SCENE.instantiate()
		satellite_2.angle = PI
		add_child(satellite_2)

