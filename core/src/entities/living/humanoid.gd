extends CharacterBody2D
class_name Humanoid

const MAX_VELOCITY: float = 600

@export var standing_collider: CollisionShape2D
@export var crouch_collider: CollisionShape2D

@export var SPEED: float = 300.0
@export var crouch_speed_modifier: float = 0.5
@export var FRICTION: float = 1000.0
@export var JUMP_VELOCITY: float = -650.0

var grip: bool = false
var direction: float = 0
var left_arm_point_vector: Vector2 = Vector2.ZERO
var right_arm_point_vector: Vector2 = Vector2.ZERO

var crouch: bool = false


func _physics_process(delta: float) -> void:
	if crouch_collider:
		crouch_collider.disabled = not crouch
		standing_collider.disabled = crouch
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * ((SPEED * crouch_speed_modifier) if crouch else SPEED), FRICTION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	velocity = velocity.limit_length(MAX_VELOCITY)
	move_and_slide()
