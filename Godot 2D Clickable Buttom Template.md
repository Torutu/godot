
This template creates a clickable button (e.g., a red circle) that toggles the visibility of an image when clicked.

---

## 1. Set Up the Scene

### 1.1 Create a Root Node
- Add a `Node2D` as the root of your scene.

### 1.2 Add a Sprite for the Button
- Add a `Sprite2D` node as a child of the root node.
- Assign a texture (e.g., a red circle image) to the `Texture` property.

### 1.3 Make the Button Clickable
- Add an `Area2D` node as a child of the `Sprite2D`.
- Add a `CollisionShape2D` as a child of the `Area2D`.
- Assign a `CircleShape2D` to the `CollisionShape2D` and adjust its radius to match the button size.

### 1.4 Add the Image to Toggle
- Add a `TextureRect` node as a child of the root node.
- Assign the image you want to toggle to the `Texture` property.
- Hide the `TextureRect` initially by unchecking the `Visible` property in the Inspector.

---

## 2. Attach the Script

### 2.1 Create a Script
- Attach a new script to the `Area2D` node.
- Name the script something like `ButtonToggler.gd`.

### 2.2 Write the Script
Use the following template:
```godot
extends Area2D

# Reference to the image node (assign in the Inspector)
@export var image_node: TextureRect

func _ready():
    # Ensure the image is hidden at the start
    if image_node:
        image_node.visible = false
        print("TextureRect is assigned and hidden at the start.")
    else:
        print("TextureRect is not assigned!")

func _on_input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.pressed:
        print("Button clicked!")
        # Toggle the visibility of the image
        if image_node:
            image_node.visible = not image_node.visible
            print("Image visibility toggled. Visible:", image_node.visible)
        else:
            print("No TextureRect assigned to image_node!")
```
## 3. Connect the `input_event` Signal

### 3.1 Select the `Area2D` Node
- In the **Scene Dock**, click on the `Area2D` node.

### 3.2 Go to the Node Tab
- Switch to the **Node** tab in the Inspector.

### 3.3 Connect the Signal
- Find the `input_event` signal and double-click it.
- Connect it to the script and ensure the method is `_on_input_event`.

---

## 4. Assign the Image Node

### 4.1 Select the `Area2D` Node
- In the **Scene Dock**, click on the `Area2D` node.

### 4.2 Assign the `TextureRect`
- In the **Inspector**, find the `image_node` variable under `Script Variables`.
- Drag the `TextureRect` node from the **Scene Dock** into the `image_node` field.

---

## 5. Test the Scene

### 5.1 Run the Scene
- Click the **Play Scene** button (triangle icon).

### 5.2 Click the Button
- Click the red circle in the game window.
- The image should appear/disappear, and you should see debug messages in the **Output** panel.

---

## 6. Reuse the Template

To reuse this template in other projects:

1. Copy the `ButtonToggler.gd` script.
2. Set up the scene structure:
   - `Node2D` (root)
     - `Sprite2D` (button)
       - `Area2D`
         - `CollisionShape2D`
     - `TextureRect` (image to toggle)
3. Attach the script to the `Area2D` node.
4. Connect the `input_event` signal.
5. Assign the `TextureRect` to the `image_node` variable.