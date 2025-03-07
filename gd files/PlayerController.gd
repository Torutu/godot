#PlayerController.gd
extends CharacterBody3D  
## Base movement speed
@export var move_speed: float = 2.0
## Speed multiplier when sprinting
@export var sprint_multiplier: float = 2.0  
## Lerp acceleration factor
@export var acceleration: float = 8.0
## Force applied to push objects
@export var push_strength: float = 10.0

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D  # Sphere mesh
@onready var collision_shape: CollisionShape3D = $CollisionShape3D  # Reference to the collision

func _debug_location()-> void:
	print("Current location: ", global_transform.origin)
func _physics_process(delta: float) -> void:
	#_debug_location() #debug print location
	var target_velocity = Vector3.ZERO  
	# Get movement input
	if Input.is_action_pressed("moveUp"):
		target_velocity.y += 1
	if Input.is_action_pressed("moveDown"):
		target_velocity.y -= 1
	if Input.is_action_pressed("moveLeft"):
		target_velocity.x -= 1
	if Input.is_action_pressed("moveRight"):
		target_velocity.x += 1
	if target_velocity != Vector3.ZERO:
		target_velocity = target_velocity.normalized()
	# Apply sprinting multiplier
	var speed = move_speed * (sprint_multiplier if Input.is_action_pressed("shift") else 1.0)
	target_velocity *= speed
	# Smoothly interpolate (lerp) between the current velocity and the target velocity
	velocity = velocity.lerp(target_velocity, acceleration * delta)
	# Move and handle collisions
	move_and_slide()
	# Apply push force to RigidBody3D objects
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody3D:
			var normal = collision.get_normal()  
			var push_force = -normal * push_strength * delta
			collider.apply_central_impulse(push_force)  
