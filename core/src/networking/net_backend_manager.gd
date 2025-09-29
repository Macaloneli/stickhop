# Autoload NetBackendManager
extends Node

const MAX_PEERS = 8

enum NetPlatformTarget {
	ENET,
	STEAM,
	WEB
}

var current_backend: BaseNetBackend


func pick_backend(target: NetPlatformTarget) -> BaseNetBackend:
	match target:
		# TODO: Add cases for Steam and web
		_:
			var new_enet_backend = ENetNetBackend.new()
			return new_enet_backend


func _ready() -> void:
	current_backend = pick_backend(NetPlatformTarget.ENET)
	add_child(current_backend)
