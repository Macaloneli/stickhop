class_name GamemodeResource
extends Resource

@export var unique_name: StringName
@export var levels: Array[LevelResource]
@export_file("*.tscn", "*.gd") var controller_path: String
