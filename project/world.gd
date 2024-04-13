extends Node3D

const SPAWN_DISTANCE := 25.0 # Should be offscreen for all

var _time_to_next_spawn := 2.0

func _physics_process(delta: float) -> void:
	_time_to_next_spawn -= delta
	
	if _time_to_next_spawn <= 0:
		_spawn_enemies()
		_time_to_next_spawn = 2.0


func _spawn_enemies() -> void:
	var enemy := preload("res://enemy.tscn").instantiate()
	enemy.target = $Hero
	add_child(enemy)
	var angle := randf_range(0, TAU)
	enemy.position = $Hero.position + Vector3(SPAWN_DISTANCE,0,0).rotated(Vector3.UP, angle)
