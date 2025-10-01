class_name BootScene
extends Node

static var done: bool = false

@export var initial_lvl: LevelResource


func _ready() -> void:
	print("BootScene ready, bootstrapping game managers. . .")
	_deferred_ready.call_deferred()


func _deferred_ready():
	_bootstrap_game_managers()
	print("Bootstrapping complete. Loading start level. . .")
	LevelManager.instance.load_lvl(initial_lvl)
	print("BootScene done!")
	done = true


func _bootstrap_game_managers():
	add_child(NetBackendManager.new())
	add_child(GamemodeManager.new())
	add_child(LevelManager.new())
	add_child(OSTManager.new())
