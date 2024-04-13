extends Control


func _on_play_button_pressed() -> void:
	%PlayButton.disabled = true
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://world.tscn")
	
