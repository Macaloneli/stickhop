class_name PhysicsRigBone
extends RigidBody2D

const RESET_DISTANCE: float = 30

@export var angular_stiffness: float = 45
@export var angular_damping: float = 1
@export var anim_rig_bone: Bone2D


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var target_distance = global_position.distance_to(anim_rig_bone.global_position)
	$CollisionShape2D.disabled = target_distance >= RESET_DISTANCE

	var target_rotation = anim_rig_bone.global_rotation

	var angle_diff = angle_difference(global_rotation, target_rotation)
	var p = angle_diff * angular_stiffness
	var d = -state.angular_velocity * angular_damping
	var torque = p + d

	state.angular_velocity += torque
