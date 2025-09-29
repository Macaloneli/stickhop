@abstract
class_name BaseNetBackend
extends Node

@abstract func get_peer() -> MultiplayerPeer


func _ready() -> void:
	connect_multiplayer_signals.call_deferred()
	setup.call_deferred()


func connect_multiplayer_signals():
	multiplayer.connected_to_server.connect(_self_connected)
	multiplayer.connection_failed.connect(_self_connect_failed)
	multiplayer.server_disconnected.connect(_server_disconnected)
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)


func setup() -> void:
	pass # Virtual method


@abstract func _self_connected()
@abstract func _self_connect_failed()
@abstract func _server_disconnected()
@abstract func _peer_connected(id: int)
@abstract func _peer_disconnected(id: int)
