extends NavigationAgent2D

const BASE_PERSONAL_SPACE: float = 64.0
const JUMP_POINT_DISTANCE: float = 64.0
const jump_y_threshold: float = 40

@export var humanoid: HumanoidAI
@export var reaction_time: float = 0.15

var current_path_pos: Vector2

@onready var reaction_timer: Timer = Timer.new()
@onready var personal_space_distance_offset: float = randf_range(-15, 20)


func _ready() -> void:
	target_desired_distance = BASE_PERSONAL_SPACE + personal_space_distance_offset

	reaction_timer.wait_time = reaction_time
	add_child(reaction_timer)


func _physics_process(_delta: float) -> void:
	if humanoid.target:
		target_position = humanoid.target.global_position
		current_path_pos = get_next_path_position()

		if is_target_reachable() and not is_target_reached():
			if reaction_timer.time_left > 0.05:
				return

			humanoid.direction = sign(current_path_pos.x - humanoid.global_position.x)
			if (
				humanoid.is_on_floor()
				and current_path_pos.y - humanoid.global_position.y <= -jump_y_threshold
				and abs(current_path_pos.x - humanoid.global_position.x) < 30
			):
				humanoid.velocity.y = humanoid.jump_velocity

			reaction_timer.start(reaction_time)
		else:
			humanoid.direction = 0
	else:
		humanoid.direction = 0
