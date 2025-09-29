extends Skeleton2D

@export var humanoid: Humanoid
@export var music_bumper: OSTRhythmNotifier

func _ready() -> void:
	get_modification_stack().enabled = true
	if music_bumper != null:
		music_bumper.beat.connect(_on_beat)


func _on_beat(_num: int):
	if humanoid.is_on_floor() and humanoid.direction == 0 and not humanoid.crouch:
		position.y += 5


func _physics_process(delta: float) -> void:
	if humanoid.crouch:
		position.y = lerp(position.y, 10.0, delta * 12)
		rotation = lerp(rotation, humanoid.direction * 0.5, delta * 12)
	else:
		position.y = lerp(position.y, 0.0, delta * 12)
		rotation = lerp(rotation, 0.0, delta * 12)
