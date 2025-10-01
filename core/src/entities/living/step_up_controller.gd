extends Node

@export var humanoid: Humanoid
@export var cast_low_right: RayCast2D
@export var cast_high_right: RayCast2D
@export var cast_low_left: RayCast2D
@export var cast_high_left: RayCast2D


func _physics_process(_delta: float) -> void:
	_process_side(cast_low_left, cast_high_left)
	_process_side(cast_low_right, cast_high_right)


func _process_side(cast_low: RayCast2D, cast_high: RayCast2D):
	var lower_hit = cast_low.is_colliding()
	var upper_hit = cast_high.is_colliding()

	if lower_hit and not upper_hit:
		var lower_point = cast_low.get_collision_point()

		var step_up_distance = (lower_point.y - 16) - lower_point.y
		if step_up_distance < 16 and humanoid.is_on_floor() and humanoid.direction != 0:
			humanoid.position.y += step_up_distance
