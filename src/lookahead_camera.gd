extends Camera2D

@export var lookahead_distance: float = 16
@export var lookahead_time: float = 4.0

func _process(delta: float) -> void:
	if get_parent() is CharacterBody2D:
		var chara: CharacterBody2D = get_parent()
		if chara.velocity.length() > 0.5:
			offset = offset.lerp(chara.velocity.normalized() * lookahead_distance, lookahead_time * delta)
