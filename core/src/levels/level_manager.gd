class_name LevelManager
extends GameManager

signal level_loaded(gamemode: StringName, lvl: LevelResource)
signal level_unloaded(gamemode: StringName, lvl: LevelResource)

var current_level_resource: LevelResource:
	get:
		return backing_current_level_resource
	set(value):
		if (
			backing_current_level_resource != null
			and backing_current_level_resource != value
			and backing_current_level_resource.level_name != value.level_name
		):
			load_lvl(value)
		backing_current_level_resource = value
var backing_current_level_resource: LevelResource

var currently_loaded_lvl: Node


func _ready() -> void:
	instance = self
	if current_level_resource:
		load_lvl.call_deferred(current_level_resource)


func unload_lvl():
	if not currently_loaded_lvl:
		return
	level_unloaded.emit("test", current_level_resource)
	if currently_loaded_lvl:
		currently_loaded_lvl.queue_free()
		currently_loaded_lvl = null
	current_level_resource = null


func load_lvl(res: LevelResource):
	unload_lvl()
	var new_level = res.load_unparented()
	owner.add_child(new_level)
	level_loaded.emit("test", new_level)
	currently_loaded_lvl = new_level
