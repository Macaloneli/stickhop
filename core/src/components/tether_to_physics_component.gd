extends Node
class_name TetherToPhysicsComponent

@export var pull_speed: float = 50.0
@export var pull_damp: float = 1.0
@export var bodyA: PhysicsBody2D
@export var bodyB: Node2D
@export var axis: Vector2


func _physics_process(delta: float) -> void:
	var pos_diff = bodyB.global_position - bodyA.global_position
	var p = pos_diff * pull_speed
	
	if bodyA.get("velocity"):
		var d = -bodyA.velocity * pull_damp
		var force = p + d
		
		if axis.x >= 1:
			bodyA.velocity.x += force.x * delta
		if axis.y >= 1:
			bodyA.velocity.y += force.y * delta
	elif bodyA.get("linear_velocity"):
		var d = -bodyA.linear_velocity * pull_damp
		var force = p + d
		
		if axis.x >= 1:
			bodyA.linear_velocity.x += force.x * delta
		if axis.y >= 1:
			bodyA.linear_velocity.y += force.y * delta
