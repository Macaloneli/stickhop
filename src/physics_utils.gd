extends Node
class_name PhysicsUtils


static func hookes_law(displacement: float, current_velocity: float, stiffness: float, damping: float):
	return (stiffness * displacement) - (damping * current_velocity)
