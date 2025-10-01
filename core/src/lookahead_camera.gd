class_name LookaheadCamera2D
extends Camera2D

@export var lookahead_distance: float = 32
@export var lookahead_time: float = 4.0


func _process(delta: float) -> void:
	if not is_multiplayer_authority():
		return

	if get_parent() is CharacterBody2D:
		var chara: CharacterBody2D = get_parent()
		if chara.velocity.length() > 0.5:
			offset = offset.lerp(
				chara.velocity.normalized() * lookahead_distance, lookahead_time * delta
			)
		else:
			offset = offset.lerp(Vector2.ZERO, lookahead_time * delta)
