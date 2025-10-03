class_name PlayerInputComponent
extends BaseNetInput

@export var humanoid: Humanoid

var state: Humanoid.HumanoidState


func _gather():
	state.direction = Input.get_axis("move_left", "move_right")
	state.movement.y = (
		Input.get_action_strength("move_jump") - Input.get_action_strength("move_crouch"))
	state.crouch = Input.is_action_pressed("move_crouch")
	state.grip = (
		Input.is_action_pressed("point_left") or Input.is_action_pressed("point_right"))
	state.left_arm_point_vector = (
		humanoid.get_global_mouse_position()
		if Input.is_action_pressed("point_left")
		else Vector2.ZERO
	)
	state.right_arm_point_vector = (
		humanoid.get_global_mouse_position()
		if Input.is_action_pressed("point_right")
		else Vector2.ZERO)