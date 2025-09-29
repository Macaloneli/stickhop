extends Node
class_name LevelController

signal level_loaded(lvl: LevelResource)
signal level_unloaded(lvl: LevelResource)

@export var current_level_resource: LevelResource


func _ready() -> void:
	if current_level_resource != null:
		load_lvl_resource.call_deferred(current_level_resource)


func load_lvl_resource(res: LevelResource):
	var new_level = res.load_unparented()
	owner.add_child(new_level)
	level_loaded.emit(new_level)
