class_name GamemodeConfigMenu
extends Node

@export_file("*.tscn") var item_button_scene_path: String
@export var item_section: Container
@export var start_button: BaseButton

@onready var gamemode_manager: GamemodeManager = GamemodeManager.instance

var cur_choice: GamemodeResource


func _start_button_pressed():
	if cur_choice == null:
		return

	LevelManager.instance.load_lvl(cur_choice.levels.front())
	queue_free()


func _button_pressed(button: GamemodeSelectItem, gm_res: GamemodeResource):
	start_button.disabled = not button.button_pressed
	if button.button_pressed:
		cur_choice = gm_res


func _ready() -> void:
	name = "GamemodeConfigMenu"
	var item_button_scene: PackedScene = load(item_button_scene_path)

	start_button.pressed.connect(_start_button_pressed)
	for item: GamemodeResource in gamemode_manager.registered_gamemodes:
		var new_item_button: GamemodeSelectItem = item_button_scene.instantiate()
		item_section.add_child(new_item_button)
		new_item_button.gamemode_name_label.text = item.unique_name
		new_item_button.info_icon.tooltip_text = item.description + "\nLevels:\n%s" % _parse_level_list(item.levels)
		new_item_button.pressed.connect(func():
			_button_pressed(new_item_button, item))


func _parse_level_list(levels: Array[LevelResource]) -> String:
	var ret: String = ""

	for level in levels:
		ret += "    - " + level.level_name + "\n"
	return ret
