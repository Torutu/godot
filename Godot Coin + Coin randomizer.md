I made a coin you can collect, once the "player" touches the coin, it disappears and increment by one
attach this script to the 3dMesh you want to be a coin
```
|-MeshInstance3D (script)
|--Area3D
|---CollisionShape3D
```
```gdscript
extends MeshInstance3D  # Attach this script to the root MeshInstance3D

# Reference to the Area3D node
@onready var area: Area3D = $Area3D

func _ready():
	# Connect the body_entered signal of the Area3D
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	# Check if the body that entered is the player
	if body.is_in_group("player"):  # Make sure your player is in the "player" group
		# Increment the player's score
		Global.player_data["score"] += 1
		print("Coin collected! Score:", Global.player_data["score"])
		queue_free() #remove the node after collecting

```

then I added a freakin randomizer, that put a specific amount of coins in an 3d area that I can decided its limits, which is freakin awesome
```gdscript
# GenericSpawner.gd
# Description: Spawns a specified number of objects at random positions within a defined area.
extends Node3D  # Attach this script to the root node of your level/world
# Reference to the object scene (assign in the Inspector)
@export var object_scene: PackedScene
# Number of objects to spawn
@export var num_spawns: int = 15
# Area boundaries for random placement
@export var spawn_area_min: Vector3 = Vector3(-5, -1.8, -2.5)
@export var spawn_area_max: Vector3 = Vector3(5, 1.8, -2.5)
# Scale of the spawned objects
@export var object_scale: Vector3 = Vector3(0.2, 0.2, 0.1)
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

```
#### these can be changed to fit what my heart desire
`@export var coin_scene: PackedScene`:the coin I made earlier is saved as a scene and this is how I call it, have to assign it in Inspector as well
`@export var num_coins: int = 50`: the amount of coin
`@export var spawn_area_min: Vector3`: the minimum coordinates the coins can spawn
`@export var spawn_area_max: Vector3`: the maximum coordinates the coins can spawn
`coin.scale = Vector3(0.2, 0.2, 0.1)`: the size of the coin

## Ideas
- collecting crystals in space while avoiding asteroids
- collecting acorns in the forest
- going through a maze while collecting coins
- shooting level where if I press `left click` it `hits` the target