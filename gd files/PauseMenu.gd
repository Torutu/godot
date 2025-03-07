#PauseMenu.gd
extends Control
func _ready() -> void:
	resume()
func resume():
	get_tree().paused = false
	self.visible = false
func pause():
	get_tree().paused = true
	self.visible = true
func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()
func _process(_delta: float) -> void:
	testEsc()
func _on_resume_pressed() -> void:
	resume()
func _on_restart_pressed() -> void:
	resume()
	Global.free_game()
	get_tree().reload_current_scene()
func _on_quit_to_menu_pressed() -> void:
	resume()
	Global.free_game()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
func _on_quit_to_desk_pressed() -> void:
	get_tree().quit()
func _on_save_pressed() -> void:
	Global.save_game()
