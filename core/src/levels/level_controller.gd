extends Node
class_name LevelController

static var instance: LevelController

signal level_loaded(gamemode: StringName, lvl: LevelResource)
signal level_unloaded(gamemode: StringName, lvl: LevelResource)

@export var current_level_resource: LevelResource
@export var gamemode_manager: GamemodeManager

var currently_loaded_lvl: Node


func _ready() -> void:
	instance = self
	if current_level_resource:
		load_lvl.call_deferred(current_level_resource)


func load_lvl(res: LevelResource):
	if currently_loaded_lvl:
		currently_loaded_lvl.queue_free()
	var new_level = res.load_unparented()
	owner.add_child(new_level)
	level_loaded.emit("test", new_level)
	currently_loaded_lvl = new_level
