extends Control

signal play

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	emit_signal("play")

func _on_button_3_pressed() -> void:
	get_tree().quit()
