class_name OSTManager
extends AudioStreamPlayer

static var instance: OSTManager


func _ready() -> void:
    instance = self
    LevelManager.instance.level_loaded.connect(_level_loaded)


func _level_loaded(lvl: LevelResource):
    if lvl.level_music:
        stream = lvl.level_music
        play()