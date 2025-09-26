extends Node
class_name PlayerInputComponent

@export var humanoid: Humanoid
@export var hips: RigidBody2D


func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_pressed("move_jump") and humanoid.is_on_floor():
		humanoid.velocity.y += humanoid.JUMP_VELOCITY
		hips.linear_velocity.y += humanoid.JUMP_VELOCITY * hips.mass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	humanoid.direction = Input.get_axis("move_left", "move_right")
	if humanoid.direction:
		humanoid.velocity.x = move_toward(humanoid.velocity.x, humanoid.direction * humanoid.SPEED, humanoid.FRICTION * delta)
	else:
		humanoid.velocity.x = move_toward(humanoid.velocity.x, 0, humanoid.FRICTION * delta)
