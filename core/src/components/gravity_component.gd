extends Node
class_name GravityComponent

@export var body: CharacterBody2D


func _physics_process(delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
