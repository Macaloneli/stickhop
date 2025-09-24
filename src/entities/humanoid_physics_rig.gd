extends Node2D

var bone_pairs: Dictionary

func _ready() -> void:
	for phys_node in NodeUtils.get_all_node2d_children_recursive(self):
		if phys_node is not RigidBody2D:
			continue
		for anim_node in NodeUtils.get_all_node2d_children_recursive(get_parent().get_node("AnimRig")):
			if anim_node is not RigidBody2D:
				continue
			
			if phys_node.name == anim_node.name:
				bone_pairs[phys_node] = anim_node


func _physics_process(delta: float) -> void:
	for phys_bone: RigidBody2D in bone_pairs:
		var rotation_difference = bone_pairs[phys_bone].rotation - phys_bone.rotation
		rotation_difference = fposmod(rotation_difference + PI, 2 * PI) - PI
		var torque = PhysicsUtils.hookes_law(rotation_difference, phys_bone.angular_velocity, 64, 1)
		phys_bone.apply_torque_impulse(torque * phys_bone.inertia)
