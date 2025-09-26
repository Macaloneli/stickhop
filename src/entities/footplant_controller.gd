extends Node
class_name FootplantController

@export var humanoid: Humanoid
@export var skeleton: Skeleton2D
@export var hips: Node2D
@export var ik_target_left: Marker2D
@export var ik_target_right: Marker2D
@export var raycast: RayCast2D


func _physics_process(delta: float) -> void:
	var avg_pos = (ik_target_left.global_position + ik_target_right.global_position) * 0.5
	var step_dest: Vector2 = Vector2.ZERO
	
	raycast.position.x = lerp(raycast.position.x, humanoid.velocity.normalized().x * 30, 3 * delta)
	var modification_stack: SkeletonModificationStack2D = skeleton.get_modification_stack()
	var two_bone_left: SkeletonModification2DTwoBoneIK = modification_stack.get_modification(0)
	var two_bone_right: SkeletonModification2DTwoBoneIK = modification_stack.get_modification(1)
	
	if humanoid.direction != 0:
		two_bone_left.flip_bend_direction = true if humanoid.direction == -1 else false
		two_bone_right.flip_bend_direction = true if humanoid.direction == -1 else false
	
	if not humanoid.is_on_floor():
		ik_target_left.global_position = humanoid.global_position + Vector2(-max(4, humanoid.velocity.normalized().y * 10), 15)
		ik_target_right.global_position = humanoid.global_position + Vector2(max(4, humanoid.velocity.normalized().y * 10), 15)
	else:
		ik_target_left.global_position.y = humanoid.global_position.y + 33
		ik_target_right.global_position.y = humanoid.global_position.y + 33
	
	if abs(avg_pos.x - hips.global_position.x) > 2 and raycast.is_colliding():
		step_dest = raycast.get_collision_point()
		var chosen_ik_target: Marker2D
		if ik_target_right.global_position.distance_to(hips.global_position) > ik_target_left.global_position.distance_to(hips.global_position):
			chosen_ik_target = ik_target_right
		else:
			chosen_ik_target = ik_target_left
		
		chosen_ik_target.global_position = chosen_ik_target.global_position.lerp(step_dest, delta * 60)
