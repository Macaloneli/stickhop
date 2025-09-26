extends Node

@export var pull_speed: float = 50.0
@export var pull_damp: float = 1.0
@export var controller: CharacterBody2D
@export var hips: Node2D


func _physics_process(delta: float) -> void:
	var angle_diff = hips.global_position - controller.global_position
	var p = angle_diff * pull_speed
	var d = -controller.velocity * pull_damp
	var force = p + d
	
	controller.velocity.x += force.x * delta
