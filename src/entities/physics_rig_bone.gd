extends RigidBody2D
class_name PhysicsRigBone

@export var anim_rig_bone: Node2D

func _physics_process(delta: float) -> void:
	var position_difference = global_position - anim_rig_bone.global_position
	var spring_force = -128 * position_difference
	var damping_force = -1 * linear_velocity
	apply_force(spring_force + damping_force)
	
	var rotation_difference = global_rotation - anim_rig_bone.global_rotation
	var torque = -128 * rotation_difference
	var damping_torque = -0.05 * angular_velocity
	
	torque += damping_torque
	apply_torque(torque)
