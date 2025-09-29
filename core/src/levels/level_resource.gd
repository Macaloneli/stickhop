extends Resource
class_name LevelResource

@export var level_name: String
@export var level_music: AudioStream
@export_file("*.tscn") var level_scene_path: String


func load_unparented():
	var packed_scene: PackedScene = ResourceLoader.load(level_scene_path)
	var root_node = packed_scene.instantiate()
	return root_node
