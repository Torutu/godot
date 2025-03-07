extends Control

@export var mainMenu : Control

func _on_exit_button_pressed() -> void:
	print("exit option menu")
	self.visible = false
	mainMenu.visible = true
