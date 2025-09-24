extends RigidBody2D
class_name PhysicsRigBone

@export var linear_stiffness: float = 450.0
@export var angular_stiffness: float = 450.0
@export var linear_damping: float = 1.0
@export var angular_damping: float = 1.0

@export var anim_rig_bone: Node2D

func _physics_process(delta: float) -> void:
	var position_difference = global_position - anim_rig_bone.global_position
	var spring_force = -linear_stiffness * position_difference
	var damping_force = -linear_damping * linear_velocity
	apply_force(spring_force + damping_force)
	
	var rotation_difference = global_rotation - anim_rig_bone.global_rotation
	var torque = -angular_stiffness * rotation_difference
	var damping_torque = -angular_damping * angular_velocity
	
	torque += damping_torque
	apply_torque(torque * delta)
