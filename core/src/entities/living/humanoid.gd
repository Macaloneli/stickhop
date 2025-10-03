class_name Humanoid
extends CharacterBody2D

const MAX_VELOCITY: float = 600

@export var standing_collider: CollisionShape2D
@export var crouch_collider: CollisionShape2D

@export var speed: float = 300.0
@export var crouch_speed_modifier: float = 0.5
@export var friction: float = 1000.0
@export var jump_velocity: float = 650.0

var peer_id: int = 0

class HumanoidState extends RefCounted:
	var grip: bool = false
	var y_input: float = 0
	var direction: float = 0
	var left_arm_point_vector: Vector2 = Vector2.ZERO
	var right_arm_point_vector: Vector2 = Vector2.ZERO

var state: HumanoidState = HumanoidState.new()

@onready var rollback_synchronizer: RollbackSynchronizer = get_node_or_null("RollbackSynchronizer")
@onready var player_input_component: PlayerInputComponent = get_node_or_null("PlayerInputComponent")


func _ready() -> void:
	await get_tree().process_frame

	set_multiplayer_authority(1) # Server is authority
	if player_input_component:
		player_input_component.set_multiplayer_authority(peer_id)
	if rollback_synchronizer:
		rollback_synchronizer.process_settings()


func _rollback_tick(delta: float, _tick: int, _is_fresh: bool) -> void:
	if crouch_collider:
		crouch_collider.disabled = state.y_input < 0
		standing_collider.disabled = state.y_input >= 0

	if state.direction:
		var final_speed = (speed * crouch_speed_modifier) if state.y_input < 0 else speed
		velocity.x = move_toward(velocity.x, state.direction * final_speed, friction * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	velocity = velocity.limit_length(MAX_VELOCITY)
	velocity *= NetworkTime.physics_factor
	move_and_slide()
	velocity /= NetworkTime.physics_factor


func jump() -> void:
	if is_on_floor():
		velocity.y = -jump_velocity