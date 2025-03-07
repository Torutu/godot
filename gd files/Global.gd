#Global.gd
extends Node
# File path for saving data
const SAVE_FILE_PATH: String = "user://save_data.save"
# Called when the node enters the scene tree for the first time
#------------------------------------STRUCT----------------------------------------------------
var player_data: Dictionary = {
	"silly_cat": 0,
	"score": 0
}
#------------------------------------  INIT  ---------------------------------------------------
func _ready() -> void:
	print("Global.gd ready")
#------------------------------------SAVE FUNC-------------------------------------------------
func save_game() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(player_data)  # Save the entire dictionary
		file.close()
		print("Game saved successfully!")
	else:
		print("Failed to save game: ", FileAccess.get_open_error())
func load_game() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			player_data = file.get_var()  # Load the entire dictionary
			file.close()
			print("Game loaded successfully!")
		else:
			print("Failed to load game: ", FileAccess.get_open_error())
	else:
		print("No save file found.")
#------------------------------------PAUSE FUNC------------------------------------------------
func free_game():
	player_data["silly_cat"] = 0
	player_data["score"] = 0
