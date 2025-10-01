class_name GamemodeManager
extends GameManager

const ERRSTR_CONTROLLER_INVALID_PATH := "Gamemode Resource %s has an invalid controller path: %s"

## Exported for debug use. Should only be given a value in-editor for said debug purposes!
@export var current_gamemode: GamemodeResource

var level_manager: LevelManager

@onready var current_gamemode_controller_handle: Node


func load_gamemode(gm_res: GamemodeResource):
	if current_gamemode:
		dispose_current_gamemode_controller()

	var controller_resource: Resource = load(gm_res.controller_path)
	if controller_resource is PackedScene:
		current_gamemode_controller_handle = controller_resource.instantiate()
	elif controller_resource is Script:
		current_gamemode_controller_handle = Node.new()
		current_gamemode_controller_handle.set_script(controller_resource)
	else:
		push_error(ERRSTR_CONTROLLER_INVALID_PATH % [gm_res.unique_name, gm_res.controller_path])
		return
	add_child(current_gamemode_controller_handle)
	current_gamemode = gm_res


func dispose_current_gamemode_controller():
	if not current_gamemode:
		return

	if current_gamemode_controller_handle:
		current_gamemode_controller_handle.queue_free()
		current_gamemode_controller_handle = null


func _ready() -> void:
	super._ready()

	if current_gamemode:
		load_gamemode.call_deferred(current_gamemode)
