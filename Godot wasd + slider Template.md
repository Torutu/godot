
control a sphere position and its size using wasd and a slider, with smoothed animation + clamps
# WASD
efficient way
```gdscript
extends BoxContainer
@onready var dsphere: MeshInstance3D = $"../MeshInstance3D" # Link of the objects
var input_map: Dictionary = {
	"move_up": Vector3(0, 1, 0),      # W key (move up)
	"move_left": Vector3(-1, 0, 0),   # A key (move left)
	"move_down": Vector3(0, -1, 0),   # S key (move down)
	"move_right": Vector3(1, 0, 0)    # D key (move right)
}
var base_speed: float = 0.005# Base speed and speed multiplier
var speed_multiplier: float = 2.0  # Double the speed when Shift is held
func _process(delta: float) -> void:
	# Calculate the current speed based on whether Shift is pressed
	var current_speed = base_speed * (speed_multiplier if Input.is_action_pressed("shift") else 1.0)    
	for action in input_map:# Handle movement based on input
		if Input.is_action_pressed(action):
			move_sphere(input_map[action], current_speed)
func move_sphere(direction: Vector3, speed: float) -> void:
	# Update the sphere's position based on direction and speed
	Global.player_data["ball_ver"] += direction.x * speed
	Global.player_data["ball_hor"] += direction.y * speed
	# Clamp the values to keep the sphere within bounds
	Global.player_data["ball_ver"] = clamp(Global.player_data["ball_ver"], -2.82, 2.83)
	Global.player_data["ball_hor"] = clamp(Global.player_data["ball_hor"], -1.05, 1.29)
	# Update the sphere's position
	dsphere.position.x = Global.player_data["ball_ver"]
	dsphere.position.y = Global.player_data["ball_hor"]
	# Print the current position for debugging
	print("Ball Position - X:", Global.player_data["ball_ver"], " Y:", Global.player_data["ball_hor"])
```
more readable way
```gdscript
extends BoxContainer
@onready var dsphere: MeshInstance3D = $"../MeshInstance3D" # Link of the objects
var input_map: Dictionary = {
	"move_up": "_on_button_pressed",      # W key
	"move_left": "_on_button_4_pressed",  # A key
	"move_down": "_on_button_3_pressed",  # S key
	"move_right": "_on_button_2_pressed"  # D key
}
var base_speed: float = 0.005# Base speed and speed multiplier
var speed_multiplier: float = 2.0  # Double the speed when Shift is held
func _process(delta: float) -> void:
	# Calculate the current speed based on whether Shift is pressed
	var current_speed = base_speed * (speed_multiplier if Input.is_action_pressed("shift") else 1.0)
	for action in input_map:# Handle movement based on input
		if Input.is_action_pressed(action):
			call(input_map[action], current_speed)  # Pass the current speed to the function
func _on_button_pressed(speed: float) -> void:  # Button 1: Up (W key)
	Global.player_data["ball_hor"] += speed
	Global.player_data["ball_hor"] = clamp(Global.player_data["ball_hor"], -1.05, 1.29)  # Clamp after updating
	dsphere.position.y = Global.player_data["ball_hor"]
	print("Ball Horizontal:", Global.player_data["ball_hor"])
func _on_button_2_pressed(speed: float) -> void:  # Button 2: Right (D key)
	Global.player_data["ball_ver"] += speed
	Global.player_data["ball_ver"] = clamp(Global.player_data["ball_ver"], -2.82, 2.83)  # Clamp after updating
	dsphere.position.x = Global.player_data["ball_ver"]
	print("Ball Vertical:", Global.player_data["ball_ver"])
func _on_button_3_pressed(speed: float) -> void:  # Button 3: Down (S key)
	Global.player_data["ball_hor"] -= speed
	Global.player_data["ball_hor"] = clamp(Global.player_data["ball_hor"], -1.05, 1.29)  # Clamp after updating
	dsphere.position.y = Global.player_data["ball_hor"]
	print("Ball Horizontal:", Global.player_data["ball_hor"])
func _on_button_4_pressed(speed: float) -> void:  # Button 4: Left (A key)
	Global.player_data["ball_ver"] -= speed
	Global.player_data["ball_ver"] = clamp(Global.player_data["ball_ver"], -2.82, 2.83)  # Clamp after updating
	dsphere.position.x = Global.player_data["ball_ver"]
	print("Ball Vertical:", Global.player_data["ball_ver"])
```

# SLIDER

```gdscript
extends Node3D

# Reference to the sphere's MeshInstance3D
@onready var sphere: MeshInstance3D = $MeshInstance3D

# Reference to the slider
@onready var slider: HSlider = $HSlider

# Reference to the label
@onready var value_label: Label = $Label

# Target values for smooth interpolation
var target_radius: float = 0.0
var target_height: float = 0.0

func _ready():
	# Initialize the slider value
	slider.value = Global.player_data["ball_radius"]
	slider.value = Global.player_data["ball_height"]
	value_label.text = "Size: " + str(slider.value)
	
	# Set initial target values
	target_radius = slider.value / 100
	target_height = slider.value / 50
	
	# Connect the slider's value_changed signal
	slider.value_changed.connect(_on_slider_value_changed)

func _process(delta: float) -> void:
	# Smoothly interpolate the sphere's radius and height
	if sphere and sphere.mesh is SphereMesh:
		sphere.mesh.radius = lerp(sphere.mesh.radius, target_radius, 0.1)
		sphere.mesh.height = lerp(sphere.mesh.height, target_height, 0.1)

func _on_slider_value_changed(value: float) -> void:
	# Update the target values for interpolation
	target_radius = value / 100
	target_height = value / 50
	
	# Update the global variables
	Global.player_data["ball_radius"] = value
	Global.player_data["ball_height"] = value
	
	# Update the label text
	value_label.text = "Size: " + str(value)

```