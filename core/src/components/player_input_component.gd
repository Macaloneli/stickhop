extends Node
class_name PlayerInputComponent

@export var humanoid: Humanoid
@export var hips: RigidBody2D


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return

	if Input.is_action_pressed("move_jump") and humanoid.is_on_floor():
		humanoid.velocity.y += humanoid.jump_velocity
		hips.linear_velocity.y += humanoid.jump_velocity * hips.mass

	humanoid.crouch = humanoid.is_on_floor() and Input.is_action_pressed("move_crouch")
	humanoid.direction = Input.get_axis("move_left", "move_right")
	humanoid.left_arm_point_vector = (
		humanoid.get_global_mouse_position()
		if Input.is_action_pressed("point_left")
		else Vector2.ZERO
	)
	humanoid.right_arm_point_vector = (
		humanoid.get_global_mouse_position()
		if Input.is_action_pressed("point_right")
		else Vector2.ZERO
	)
	if (
		humanoid.left_arm_point_vector != Vector2.ZERO
		or humanoid.right_arm_point_vector != Vector2.ZERO
	):
		humanoid.grip = true
	else:
		humanoid.grip = false
