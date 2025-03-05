![[Pasted image 20250301232335.png]]
![[Pasted image 20250301232415.png]]



add input
![[Pasted image 20250301232542.png]]

add global file
![[Pasted image 20250301233047.png]]
I like to use the Global file to have my Dictionaries (structs or classes if you use c and c++)
and main utils stuff like save files and load files
for example
```gdscript
extends Node

# File path for saving data
const SAVE_FILE_PATH: String = "user://save_data.save"
# Called when the node enters the scene tree for the first time.

var player_data: Dictionary = {
	"silly_cat": 0,
	"ball_radius": 0.0,
	"ball_height": 0.0,
	"ball_ver": 0.0,
	"ball_hor": 0.0
}

func _ready() -> void:
	print("Global.gd ready")

func save_game() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(player_data["silly_cat"])
	print("Game saved successfully!")

func load_game() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
			var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
			player_data["silly_cat"] = file.get_var(player_data["silly_cat"])
			print("Game loaded successfully!")
	else:
		print("can't find save file")
		player_data["silly_cat"] = 0;
```

to use anything from the global file the first argument will be the name of the file 
for example here we are accessing the Dictionary
```gdscript
Global.player_data["silly_cat"]
```