```gdscript
extends Area2D
# Reference to the image node (assign in the Inspector)
@onready var image_node: TextureRect = $"../../TextureRect"
@onready var audio_player: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var click_label: Label = $Label
var fade_tween: Tween = null# Variable to store the current Tween
func _ready():
	if image_node:# Ensure the image is hidden at the start
		image_node.visible = false
		image_node.modulate.a = 0  # Start fully transparent
		print("TextureRect is assigned and hidden at the start.")
	else:
		print("TextureRect is not assigned!")
	print("Click Label:", click_label)
	update_label()# Initialize the label text
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Button clicked!")
		Global.player_data["silly_cat"] += 1# Increment the click counter
		if image_node:# Play the fade animation
			play_fade_animation()
			audio_player.play()  # Play the vine-boom sound effect
		else:
			print("No TextureRect assigned to image_node!")
		update_label()# Update the label text
func play_fade_animation():
	image_node.visible = true# Ensure the image is visible
	image_node.modulate.a = 1.0# Reset the modulate alpha to 1 (fully visible)
	if fade_tween:# Stop any existing Tween animation
		fade_tween.kill()  # Stop the current Tween
	fade_tween = create_tween()# Create a new Tween and bind it to this node
	fade_tween.tween_property(# Use the Tween to fade out the image
		image_node,  # Target node
		"modulate:a",  # Property to animate (alpha channel of modulate)
		0.0,  # Target value (fully transparent)
		1.0  # Duration of the animation (1 second)
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
func update_label():
	if click_label:# Update the label text with the current click count
		click_label.text = "Clicks: " + str(Global.player_data["silly_cat"])
	else:
		print("No Label assigned to click_label!")
```