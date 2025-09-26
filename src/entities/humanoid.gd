extends CharacterBody2D
class_name Humanoid


@export var SPEED = 300.0
@export var FRICTION = 1000.0
@export var JUMP_VELOCITY = -650.0

var direction: int = 0

func _physics_process(delta: float) -> void:
	move_and_slide()
