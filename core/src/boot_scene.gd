class_name BootScene
extends Node

const MAIN_MENU_SCENE_PATH: String = "res://src/scenes/main_menu.tscn"


func _ready() -> void:
    print("BootScene ready, bootstrapping game managers. . .")
    _bootstrap_game_managers()
    print("Bootstrapping complete, changing to main menu scene. . .")
    get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)
    print("Scene change complete.")


func _bootstrap_game_managers():
    add_child(NetBackendManager.new())
    add_child(GamemodeManager.new())
    add_child(LevelManager.new())
    add_child(OSTManager.new())