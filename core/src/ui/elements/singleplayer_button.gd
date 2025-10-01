extends Button

@export_file("*.tscn") var submenu_scene_path: String


func _pressed() -> void:
	var submenu_scene: PackedScene = load(submenu_scene_path)
	get_tree().current_scene.add_child(submenu_scene.instantiate())
	if owner is Control:
		owner.visible = false
