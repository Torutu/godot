#Collectible.gd
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
