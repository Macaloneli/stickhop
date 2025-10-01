class_name GamemodeResource
extends Resource

@export var unique_name: StringName
@export_multiline var description: String
@export var levels: Array[LevelResource]
@export_file("*.tscn", "*.gd") var controller_path: String
