#MainMenu.gd
extends VBoxContainer

@export var option : Control

func _ready() -> void:
	print("Start Button is ready")
	$CatButton.grab_focus()
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/silly cat.tscn")
func _on_ball_buttom_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/CollectCoin.tscn")
func _on_park_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dialogue.tscn")
func _on_simon_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/SimonSays.tscn")
func _on_options_button_pressed() -> void:
	option.visible = true
	self.visible = false
func _on_quit_button_pressed() -> void:
	get_tree().quit()
func _on_load_button_pressed() -> void:
	Global.load_game()
