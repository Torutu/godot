#ClickableObject.gd
extends Node2D

# Reference to the image node (assign in the Inspector)
@export var image_node: TextureRect
@export var click_label: Label
@export var audio_player: AudioStreamPlayer
var fade_tween: Tween = null  # Variable to store the current Tween

func _ready():
	if image_node:
		# Ensure the image is hidden at the start
		image_node.visible = false
		image_node.modulate.a = 0  # Start fully transparent
		print("TextureRect is assigned and hidden at the start.")
	else:
		print("TextureRect is not assigned!")
	print("Click Label:", click_label)
	update_label()  # Initialize the label text

# Public function to trigger the click behavior
func handle_click() -> void:
	print("Button clicked!")
	Global.player_data["silly_cat"] += 1  # Increment the click counter
	if image_node:
		play_fade_animation()
		audio_player.play()
	else:
		print("No TextureRect assigned to image_node!")
	update_label()  # Update the label text

func play_fade_animation():
	image_node.visible = true  # Ensure the image is visible
	image_node.modulate.a = 1.0  # Reset the modulate alpha to 1 (fully visible)
	if fade_tween:
		fade_tween.kill()  # Stop the current Tween
	fade_tween = create_tween()  # Create a new Tween and bind it to this node
	fade_tween.tween_property(
		image_node,  # Target node
		"modulate:a",  # Property to animate (alpha channel of modulate)
		0.0,  # Target value (fully transparent)
		1.0  # Duration of the animation (1 second)
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

func update_label():
	if click_label:
		# Update the label text with the current click count
		click_label.text = "Clicks: " + str(Global.player_data["silly_cat"])
	else:
		print("No Label assigned to click_label!")
