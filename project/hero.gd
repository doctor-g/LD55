extends CharacterBody3D

signal summoned_satellites
signal death_finished

const SPEED := 20.0
const ACCELERATION := 1.0
const SATELLITE_SCENE := preload("res://satellite.tscn")

var alive := true
var charges := 1:
	set(value):
		charges = value
		_update_charges_label()
var score := 0:
	set(value):
		score = value
		_update_score_label()


@onready var _shell := $Shell
@onready var _satellites := $Satellites


func _ready() -> void:
	_update_charges_label()
	_update_score_label()


func _physics_process(delta: float) -> void:
	if not alive:
		return
		
	$Heart.rotate_y(delta*0.1)
	
	var direction := Input.get_vector("move_left", "move_right", "move_down", "move_up")
	var vector := Vector3(direction.x, 0, -direction.y).normalized()
	var target_velocity := vector * SPEED
	
	velocity = velocity.move_toward(target_velocity, ACCELERATION)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("summon") and charges > 0:
		charges -= 1
		
		for satellite in _satellites.get_children():
			satellite.orbital += 1
		
		for i in 2:
			var satellite := SATELLITE_SCENE.instantiate()
			_satellites.add_child(satellite)
			satellite.angle = PI * i
			satellite.hit_enemy.connect(func():
				if alive:
					score += 10
			)
		
		$SummonSound.play()
		summoned_satellites.emit()


func charge() -> void:
	if not alive: 
		return
	
	charges += 1
	score += 5
	$PickupSound.play()


func damage() -> void:
	if not alive:
		return
	
	if _shell != null:
		%ShellParticles.emitting = true
		$ShatterSound.play()
		%HeartLight.visible = true
		_shell.queue_free()
	else:
		alive = false
		%HeartLight.visible = false
		for satellite in _satellites.get_children():
			satellite.disconnect_from_nucleus()
		$AnimationPlayer.play("death")
		$GameOverSound.play()


func _update_charges_label() -> void:
	%ChargesLabel.text = "Charges\n%d" % charges
	

func _update_score_label() -> void:
	%ScoreLabel.text = "Score\n%d" % score


func _scale_to_zero() -> void:
	await create_tween().tween_property($Heart, "scale", Vector3.ZERO, 1.0).finished
	death_finished.emit()
