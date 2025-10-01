class_name GamemodeTest
extends Node

@export var test_gamemodes: Array[GamemodeResource]


func _process(delta: float) -> void:
	if GamemodeManager.instance != null:
		set_process(false)
		_register_test_gamemode()


func _register_test_gamemode():
	for gm: GamemodeResource in test_gamemodes:
		GamemodeManager.instance.register_gamemode(gm)
