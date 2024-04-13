extends Node3D

static var _use_splash := true

func _ready() -> void:
	if not _use_splash:
		$Splash.queue_free()
		_show_main_ui()


func _on_play_button_pressed() -> void:
	%PlayButton.disabled = true
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://world.tscn")


func _on_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)


func _on_splash_splash_dismissed() -> void:
	$Music.play()
	await create_tween().tween_property($Splash, "modulate:a", 0, 0.5).finished
	$Splash.queue_free()
	_show_main_ui()
	_use_splash = false


func _show_main_ui() -> void:
	$MainUI.visible = true
	$MainUI.modulate.a = 0
	create_tween().tween_property($MainUI, "modulate:a", 1, 0.5)
