extends Node
class_name ArmController

const RESTING_ARM_STIFFNESS: float = 20
const POINT_ARM_STIFFNESS: float = 80

@export var humanoid: Humanoid
@export var skeleton: Skeleton2D
@export var left_arm_phys_bones: Array[PhysicsRigBone]
@export var right_arm_phys_bones: Array[PhysicsRigBone]
@export var target_left: Node2D
@export var target_right: Node2D
@export var grip_area_left: Area2D
@export var grip_area_right: Area2D

var grip_joint_left: FixedJoint2D
var grip_joint_right: FixedJoint2D

enum LimbSide {
	LEFT,
	RIGHT
}


func _physics_process(_delta: float) -> void:
	var modification_stack: SkeletonModificationStack2D = skeleton.get_modification_stack()
	var two_bone_left: SkeletonModification2DTwoBoneIK = modification_stack.get_modification(2)
	var two_bone_right: SkeletonModification2DTwoBoneIK = modification_stack.get_modification(3)
	two_bone_left.flip_bend_direction = false if sign(humanoid.left_arm_point_vector.x - humanoid.global_position.x) < 0 else true
	two_bone_right.flip_bend_direction = false if sign(humanoid.right_arm_point_vector.x - humanoid.global_position.x) < 0 else true
	
	target_left.global_position = humanoid.left_arm_point_vector if humanoid.left_arm_point_vector != Vector2.ZERO else humanoid.global_position
	target_right.global_position = humanoid.right_arm_point_vector if humanoid.right_arm_point_vector != Vector2.ZERO else humanoid.global_position
	for bone in left_arm_phys_bones:
		if humanoid.left_arm_point_vector != Vector2.ZERO:
			bone.angular_stiffness = POINT_ARM_STIFFNESS
		else:
			bone.angular_stiffness = RESTING_ARM_STIFFNESS
	for bone in right_arm_phys_bones:
		if humanoid.right_arm_point_vector != Vector2.ZERO:
			bone.angular_stiffness = POINT_ARM_STIFFNESS
		else:
			bone.angular_stiffness = RESTING_ARM_STIFFNESS

	if humanoid.left_arm_point_vector != Vector2.ZERO:
		_process_grip(LimbSide.LEFT)
	else:
		if grip_joint_left != null:
			grip_joint_left.queue_free()
	if humanoid.right_arm_point_vector != Vector2.ZERO:
		_process_grip(LimbSide.RIGHT)
	else:
		if grip_joint_right != null:
			grip_joint_right.queue_free()


func _process_grip(side: LimbSide):
	var colliding: bool
	var joint_already_exists: bool
	var hand: PhysicsRigBone
	var area: Area2D
	match side:
		LimbSide.LEFT:
			joint_already_exists = grip_joint_left != null
			hand = left_arm_phys_bones.back()
			area = grip_area_left
		LimbSide.RIGHT:
			joint_already_exists = grip_joint_right != null
			hand = right_arm_phys_bones.back()
			area = grip_area_right
	colliding = area.has_overlapping_bodies()
	
	if humanoid.grip and colliding and not joint_already_exists:
		var obj: Node2D = area.get_overlapping_bodies().front()
		if obj == null:
			return
		var grip_joint = FixedJoint2D.new()
		match side:
			LimbSide.LEFT:
				grip_joint_left = grip_joint
			LimbSide.RIGHT:
				grip_joint_right = grip_joint
		grip_joint.node_b = obj.get_path()
		grip_joint.node_a = hand.get_path()
		area.add_child(grip_joint)
	elif not humanoid.grip and joint_already_exists:
		match side:
			LimbSide.LEFT:
				grip_joint_left.queue_free()
			LimbSide.RIGHT:
				grip_joint_right.queue_free()
