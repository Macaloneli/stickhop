class_name ENetNetBackend
extends BaseNetBackend

const PORT: int = 5999

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()


func get_peer():
	return peer


func host_game() -> Error:
	peer = ENetMultiplayerPeer.new()
	var ret = peer.create_server(PORT, NetBackendManager.MAX_PEERS)
	if ret == OK:
		multiplayer.multiplayer_peer = peer
	return ret


func join_game(ip: String) -> Error:
	peer = ENetMultiplayerPeer.new()
	var ret = peer.create_client(ip, PORT)
	if ret == OK:
		multiplayer.multiplayer_peer = peer
	return ret


func _peer_connected(_id: int):
	pass


func _peer_disconnected(_id: int):
	pass


func _self_connected():
	pass


func _self_disconnected():
	pass


func _self_connect_failed():
	pass


func _server_disconnected():
	pass
