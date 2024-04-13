extends CharacterBody3D

const SPEED := 20.0
const ACCELERATION := 1.0
const SATELLITE_SCENE := preload("res://satellite.tscn")

@onready var _satellites := $Satellites

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_down", "move_up")
	var vector := Vector3(direction.x, 0, -direction.y).normalized()
	var target_velocity := vector * SPEED
	
	velocity = velocity.move_toward(target_velocity, ACCELERATION)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("summon"):
		# Move all the other ones out a unit
		for satellite in _satellites.get_children():
			satellite.orbital += 1
		
		var satellite_1 := SATELLITE_SCENE.instantiate()
		_satellites.add_child(satellite_1)
		var satellite_2 := SATELLITE_SCENE.instantiate()
		satellite_2.angle = PI
		_satellites.add_child(satellite_2)


func charge() -> void:
	print("Charging up!")


func damage() -> void:
	print("OUCH")
