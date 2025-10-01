class_name NetBackendManager
extends GameManager

enum NetPlatformTarget { ENET, STEAM, WEB }

const MAX_PEERS = 8

var current_backend: BaseNetBackend


func pick_backend(target: NetPlatformTarget) -> BaseNetBackend:
	match target:
		# TODO: Add cases for Steam and web
		_:
			var new_enet_backend = ENetNetBackend.new()
			return new_enet_backend


func _ready() -> void:
	super._ready()
	current_backend = pick_backend(NetPlatformTarget.ENET)
	add_child(current_backend)
	current_backend.setup.call_deferred()
