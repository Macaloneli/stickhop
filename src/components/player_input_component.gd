extends Node
class_name PlayerInputComponent

@export var humanoid: Humanoid

func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and humanoid.is_on_floor():
		humanoid.velocity.y = humanoid.JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		humanoid.velocity.x = move_toward(humanoid.velocity.x, direction * humanoid.SPEED, humanoid.FRICTION * delta)
	else:
		humanoid.velocity.x = move_toward(humanoid.velocity.x, 0, humanoid.FRICTION * delta)
