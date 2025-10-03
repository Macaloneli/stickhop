class_name GravityComponent
extends Node

@export var body: CharacterBody2D


func _rollback_tick(delta: float, _tick: int, _is_fresh: bool) -> void:
	if not body.is_on_floor():
		body.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
