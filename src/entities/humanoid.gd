extends CharacterBody2D
class_name Humanoid


const SPEED = 300.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -900.0


func _physics_process(delta: float) -> void:
	move_and_slide()
