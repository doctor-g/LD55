extends Node3D


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
	$MainUI.visible = true
	$MainUI.modulate.a = 0
	create_tween().tween_property($MainUI, "modulate:a", 1, 0.5)
