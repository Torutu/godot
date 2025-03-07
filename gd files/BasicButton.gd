#BasicButton.gd
extends TextureButton

# Reference to the Area2D node (assign in the Inspector)
@export var clickable_object: Node2D

func _on_pressed() -> void:
	print("Pressed!!")
	if clickable_object:
		clickable_object.handle_click()  # Trigger the click behavior in the Area2D script
	else:
		print("No clickable object assigned!")
