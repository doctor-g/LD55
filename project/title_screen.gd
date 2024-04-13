extends Node3D


func _on_play_button_pressed() -> void:
	%PlayButton.disabled = true
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://world.tscn")


func _on_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)
