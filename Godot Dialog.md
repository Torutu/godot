A dialog level with yes and no option, and each option gives a different response, using `RichDialogLabel` to add colors and be a bit more creative with the text to add flavour
```gdscript
# DialogController.gd
extends CanvasLayer

# Reference to the dialog box and its children
@onready var dialog_box: Panel = $DialogBox
@onready var dialog_label: RichTextLabel = $DialogBox/RichDialogLabel
@onready var yes_button: Button = $DialogBox/ChoiceContainer/YesButton
@onready var no_button: Button = $DialogBox/ChoiceContainer/NoButton

func _ready():
	# Initialize the dialog
	show_dialog("[color=green]The park is beautiful, isn't it? 🌳🌸[/color]")
	
	# Connect button signals
	yes_button.pressed.connect(_on_yes_button_pressed)
	
	no_button.pressed.connect(_on_no_button_pressed)

func show_dialog(text: String) -> void:
	# Set the dialog text and make the dialog box visible
	dialog_label.text = text
	dialog_box.visible = true

func hide_dialog() -> void:
	# Hide the dialog box
	dialog_box.visible = false

func _on_yes_button_pressed() -> void:
	print("Player chose: Yes, it is")
	#hide_dialog()  # Hide the dialog after the choice is made
	show_dialog("[color=pink]Yaaay I love the park too!! ╰(*°▽°*()╯[/color]")
func _on_no_button_pressed() -> void:
	print("Player chose: NO!")
	show_dialog("[color=red]WHY NOT??!!! 😡[/color]")
	#hide_dialog()  # Hide the dialog after the choice is made

```