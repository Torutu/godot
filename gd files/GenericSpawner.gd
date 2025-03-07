# GenericSpawner.gd
# Description: Spawns a specified number of objects at random positions within a defined area.
extends Node3D  # Attach this script to the root node of your level/world
## Reference to the object scene (assign in the Inspector)
@export var object_scene: PackedScene
## Number of objects to spawn
@export var num_spawns: int = 1000
## Min Area boundaries for random placement
@export var spawn_area_min: Vector3 = Vector3(-5, -2.4, -2.5)
## Max Area boundaries for random placement
@export var spawn_area_max: Vector3 = Vector3(5, 2.8, -2.5)
## Scale of the spawned objects
@export var object_scale: Vector3 = Vector3(0.2, 0.2, 0.1)
@export var counter: RichTextLabel

func _process(delta: float) -> void:
	counter.text = str(Global.player_data["score"])
func _ready():
	spawn_objects()  # Spawn the objects when the scene loads
func spawn_objects():
	for i in range(num_spawns):
		# Create a new instance of the object scene
		var object = object_scene.instantiate()
		# Generate a random position within the defined area
		var random_position = Vector3(
			randf_range(spawn_area_min.x, spawn_area_max.x),
			randf_range(spawn_area_min.y, spawn_area_max.y),
			randf_range(spawn_area_min.z, spawn_area_max.z)
		)
		# Add the object to the scene
		add_child(object)
		# Set the object's position
		object.global_transform.origin = random_position
		# Set the object's scale
		object.scale = object_scale
		# Print the object's position for debugging
		print("Spawned object", i, " at:", random_position)
