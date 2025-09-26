extends NavigationAgent2D

@export var humanoid: HumanoidAI
@export var jump_shapecast_low: ShapeCast2D

var current_path_pos: Vector2


func _physics_process(delta: float) -> void:
	if humanoid.target and humanoid.target.global_position.distance_to(humanoid.global_position) >= 70:
		target_position = humanoid.target.global_position
		current_path_pos = get_next_path_position()
	
		humanoid.direction = sign(current_path_pos.x - humanoid.global_position.x)
		humanoid.velocity.x = move_toward(humanoid.velocity.x, humanoid.direction * humanoid.SPEED, humanoid.FRICTION * delta)
		if (not jump_shapecast_low.is_colliding()) and humanoid.is_on_floor():
			humanoid.velocity.y = humanoid.JUMP_VELOCITY
	else:
		humanoid.direction = 0
		humanoid.velocity.x = move_toward(humanoid.velocity.x, 0, humanoid.FRICTION * delta)
