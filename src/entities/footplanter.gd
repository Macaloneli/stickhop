extends Marker2D

@export var humanoid: Humanoid
@export var footplant_raycast: RayCast2D
@export var max_footplant_distance: float = 5.0
@export var footplant_lerp_speed: float = 10.0

var rest_position: Vector2


func _ready() -> void:
	rest_position = global_position


func _physics_process(delta: float) -> void:
	pass
