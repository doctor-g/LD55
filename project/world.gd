extends Node3D

const SPAWN_DISTANCE := 25.0 # Should be offscreen for all
const SECONDS_PER_SPAWN_DECAY_PER_SPAWN := 0.1

@export var spawn_rate : Curve
@export var seconds_until_max_spawn_rate := 30.0

var _seconds_to_next_spawn := 0.0
var _elapsed_seconds := 0.0
var _ready_to_play_again := false


func _ready() -> void:
	# If this was left visible during editing, turn it off
	%PlayAgainLabel.visible = false


func _physics_process(delta: float) -> void:
	_elapsed_seconds += delta
	_seconds_to_next_spawn -= delta
	
	if _seconds_to_next_spawn <= 0 and $Hero.alive:
		_spawn_enemies()
		var spawns_per_second := spawn_rate.sample(_elapsed_seconds / seconds_until_max_spawn_rate)
		_seconds_to_next_spawn = 1.0 / spawns_per_second


func _spawn_enemies() -> void:
	var enemy := preload("res://enemy.tscn").instantiate()
	enemy.target = $Hero
	add_child(enemy)
	var angle := randf_range(0, TAU)
	enemy.position = $Hero.position + Vector3(SPAWN_DISTANCE,0,0).rotated(Vector3.UP, angle)


func _on_hero_death_finished() -> void:
	%PlayAgainLabel.visible = true
	_ready_to_play_again = true


func _input(event: InputEvent) -> void:
	if _ready_to_play_again and event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE:
			get_tree().change_scene_to_file("res://world.tscn")
		else:
			get_tree().change_scene_to_file("res://title_screen.tscn")
