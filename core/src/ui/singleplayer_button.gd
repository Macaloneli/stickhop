extends Button

@export var proto_level: LevelResource


func _pressed() -> void:
	LevelManager.instance.load_lvl.call_deferred(proto_level)
	owner.queue_free()
