I have learned how to make a quick menu and that it is better to null every value once you are done.
the reason for that is because I had an issue where when I quit to main menu then I come back
to the ball game the ball would jump to a "random" location because the Dictionary still saves the value from last instance, so I learned to zero every possible value once I'm done with the scene so it can be reused with no weird issue
here is how I made a menu to quit to main menu or quit to desktop
# In-game Menu 0.1
```gdscript
extends VBoxContainer

@onready var dsphere: MeshInstance3D = $"../MeshInstance3D" #sphere
@onready var slider: HSlider = $"../HSlider" #slider

func _on_to_menu_pressed() -> void:
	Global.player_data["ball_hor"] = 0.0
	Global.player_data["ball_ver"] = 0.0
	slider.value = 0
	
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_to_desk_pressed() -> void:
	get_tree().quit()

```
![[Pasted image 20250302002458.png]]

# In-Game Menu 0.2
```gdscript
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
```
![[Pasted image 20250304023940.png]]