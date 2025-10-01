class_name LevelManager
extends GameManager

signal level_loaded(lvl: LevelResource)
signal level_unloading(lvl: LevelResource)

static var instance: LevelManager

var current_level_resource: LevelResource:
	get:
		return backing_current_level_resource
	set(value):
		if (
			value != null
			and backing_current_level_resource != null
			and backing_current_level_resource != value
		):
			load_lvl(value)
		backing_current_level_resource = value
var backing_current_level_resource: LevelResource

var currently_loaded_lvl: Node


func _ready() -> void:
	instance = self
	name = "LevelManager"
	if current_level_resource:
		load_lvl.call_deferred(current_level_resource)


func unload_lvl():
	if currently_loaded_lvl:
		level_unloading.emit(current_level_resource)
		currently_loaded_lvl.queue_free()
		currently_loaded_lvl = null
	current_level_resource = null


func load_lvl(res: LevelResource):
	unload_lvl()
	var new_level: Node = res.load_unparented()
	add_child(new_level)
	backing_current_level_resource = res
	currently_loaded_lvl = new_level
	level_loaded.emit(res)
