extends Node2D
class_name PlayerSpawner

@export var spawn_limit = 10
@export_file("*.tscn") var player_scene_path: String

var spawned_nodes: Array[Node2D]
var load_signal_connected: bool = false

@onready var player_scene: PackedScene = load(player_scene_path)


func _ready():
	spawn.call_deferred()


func spawn():
	if len(spawned_nodes) >= spawn_limit:
		return
	
	var new_player: Node2D = player_scene.instantiate()
	new_player.global_position = global_position
	owner.add_child(new_player)
