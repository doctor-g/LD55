extends Control

signal splash_dismissed

var _done := false

func _on_gui_input(event: InputEvent) -> void:
	if not _done and event is InputEventMouseButton and event.is_pressed():
		splash_dismissed.emit()
		_done = true
