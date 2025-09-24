extends Camera2D

@export var lookahead_distance: float = 100.0
@export var lookahead_time: float = 4.0

func _process(delta: float) -> void:
	if get_parent() is CharacterBody2D:
		var chara: CharacterBody2D = get_parent()
		offset = offset.lerp(chara.velocity.normalized() * lookahead_distance, lookahead_time * delta)
