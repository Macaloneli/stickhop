extends RigidBody2D
class_name PhysicsRigBone

@export var angular_stiffness: float = 45
@export var angular_damping: float = 1
@export var anim_rig_bone: Bone2D

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:	
	var target_rotation = anim_rig_bone.global_rotation
	
	var angle_diff = target_rotation - global_rotation
	var p = angle_diff * angular_stiffness
	var d = -state.angular_velocity * angular_damping
	var torque = p + d
	
	state.angular_velocity += torque
