extends Node3D

# Exported arrays for colors and lights
@export var colors: Array[MeshInstance3D]
@export var colorLights: Array[OmniLight3D]

# Emission strength values
@export var normal_emission_strength: float = 0.6
@export var strong_emission_strength: float = 1.2  # Stronger emission

@export var intro: Label3D
@export var win: Label3D
@export var lose: Label3D

# Track the current sequence and step
var sequence = []
var player_sequence = []
var sequence_index = 0
var color_clicked: MeshInstance3D
var difficulty: int = 6

func _ready() -> void:
	win.visible = false
	lose.visible = false
	intro.visible = true
	# Initialize all emissions to off
	for i in range(colors.size()):
		toggle_emission(i, false)
	start_game()
func start_game():
	generate_sequence()
	play_sequence()

func generate_sequence():
	if sequence.size() < difficulty:
		var random_index = randi() % colors.size()
		sequence.append(colors[random_index])
	else:
		intro.visible = false
		await get_tree().create_timer(0.2).timeout
		win.visible = true
		print("good job!🤗")
		game_over()
@export var no_interact: CanvasLayer
func play_sequence():
	# Show the no_interact CanvasLayer
	$red/red_area.visible = false
	$green/green_area.visible = false
	$yellow/yellow_area.visible = false
	$blue/blue_area.visible = false
	await get_tree().create_timer(0.8).timeout
	for color in sequence:
		await get_tree().create_timer(0.2).timeout
		highlight_color(color)
		await get_tree().create_timer(0.6).timeout  # Wait for 1 second before showing the next color
	print("now colors are visible")
	$red/red_area.visible = true
	$green/green_area.visible = true
	$yellow/yellow_area.visible = true
	$blue/blue_area.visible = true
func highlight_color(color: MeshInstance3D):
	var index = colors.find(color)
	if index != -1:
		toggle_emission(index, true, false)  # Highlight the color
		await get_tree().create_timer(0.5).timeout  # Wait for 0.5 seconds
		toggle_emission(index, false)  # Turn off the highlight
		await get_tree().create_timer(0.5).timeout  # Wait for 0.5 seconds
	else:
		print("Color not found in colors array:", color)

func _on_area_input_event(color_index: int, _camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Mouse button pressed
			print("pressed")
			var clicked_color = colors[color_index]
			toggle_emission(color_index, true, true)  # Strong emission
			player_sequence.append(clicked_color)
			# Change the size of the clicked object along the Z-axis
			var clicked_object = colors[color_index]  # Assuming colors[color_index] is the Area3D
			var mesh_instance = clicked_object  # Get the MeshInstance3D
			if mesh_instance is MeshInstance3D:
				# Save the original scale
				mesh_instance.set_meta("original_scale", mesh_instance.scale)
				# Set the target scale (reduce Z-axis size)
				mesh_instance.scale = Vector3(mesh_instance.scale.x, mesh_instance.scale.y, mesh_instance.scale.z * 0.5)
			# Revert to normal emission
			toggle_emission(color_index, true)
			check_player_input()
		else:
			# Mouse button released
			var clicked_object = colors[color_index]  # Assuming colors[color_index] is the Area3D
			var mesh_instance = clicked_object  # Get the MeshInstance3D
			if mesh_instance is MeshInstance3D:
				# Reset the scale to the original value
				if mesh_instance.has_meta("original_scale"):
					mesh_instance.scale = mesh_instance.get_meta("original_scale")
			toggle_emission(color_index, true)
func check_player_input():
	for i in range(player_sequence.size()):
		if player_sequence.size() > sequence.size():
			lose.visible = true
			game_over()
		if player_sequence[i] != sequence[i]:
			lose.visible = true
			game_over()
	if player_sequence.size() == sequence.size():
		player_sequence.clear()
		await get_tree().create_timer(0.3).timeout
		generate_sequence()
		play_sequence()
func game_over():
	print("Game Over!")
	intro.visible = false
	get_tree().paused = true
	Global.block_esc()
	$fin/GameOverMenu.visible = true
	# Reset the game or show a game over screen
	sequence.clear()
	player_sequence.clear()
	sequence_index = 0
func toggle_emission(index: int, enabled: bool, strong: bool = false) -> void:
	if index >= 0 and index < colors.size():
		var mesh = colors[index]
		if mesh:
			var mat = mesh.get_active_material(0)
			if mat:
				# Enable or disable emission
				mat.set("emission_enabled", enabled)
				# Set emission strength
				if enabled:
					if strong:
						mat.set("emission_energy_multiplier", strong_emission_strength)
					else:
						mat.set("emission_energy_multiplier", normal_emission_strength)
				else:
					mat.set("emission_energy_multiplier", 0.0)  # Turn off emission
				mesh.set_surface_override_material(0, mat)
				# Sync the light color and visibility with the emission
				if index < colorLights.size():
					var light = colorLights[index]
					if light:
						if enabled:
							light.visible = true
							light.light_color = mat.get("emission")  # Set light color to emission color
							if strong:
								light.light_energy = strong_emission_strength  # Increase light energy
							else:
								light.light_energy = normal_emission_strength
						else:
							light.visible = false
				#print("Emission toggled for:", mesh.name, " | Strong:", strong)
			else:
				print("No material found for:", mesh.name)
		else:
			print("MeshInstance3D is null.")
	else:
		print("Invalid index:", index)
func _on_area_mouse_entered(index: int) -> void:
	toggle_emission(index, true)
func _on_area_mouse_exited(color_index: int) -> void:
	toggle_emission(color_index, false)
	var clicked_object = colors[color_index]  # Assuming colors[color_index] is the Area3D
	var mesh_instance = clicked_object  # Get the MeshInstance3D
	if mesh_instance is MeshInstance3D:
		# Reset the scale to the original value
		if mesh_instance.has_meta("original_scale"):
			mesh_instance.scale = mesh_instance.get_meta("original_scale")
	print("oh he exited")
#-------------------------------------------------INPUT EVENTS---------------------------------------------------
func _on_red_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_input_event(0, camera, event, event_position, normal, shape_idx)
func _on_green_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_input_event(1, camera, event, event_position, normal, shape_idx)
func _on_yellow_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_input_event(2, camera, event, event_position, normal, shape_idx)
func _on_blue_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_input_event(3, camera, event, event_position, normal, shape_idx)
#-------------------------------------------------MOUSE TOUCH---------------------------------------------------
func _on_red_area_mouse_entered() -> void:
	_on_area_mouse_entered(0);
func _on_green_area_mouse_entered() -> void:
	_on_area_mouse_entered(1);
func _on_yellow_area_mouse_entered() -> void:
	_on_area_mouse_entered(2);
func _on_blue_area_mouse_entered() -> void:
	_on_area_mouse_entered(3);
#-------------------------------------------------MOUSE EXIT---------------------------------------------------
func _on_red_area_mouse_exited() -> void:
	_on_area_mouse_exited(0);
func _on_green_area_mouse_exited() -> void:
	_on_area_mouse_exited(1);
func _on_yellow_area_mouse_exited() -> void:
	_on_area_mouse_exited(2);
func _on_blue_area_mouse_exited() -> void:
	_on_area_mouse_exited(3);
