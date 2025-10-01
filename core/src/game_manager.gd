@abstract class_name GameManager
extends Node

static var instance: GameManager

func _ready() -> void:
    instance = self
    reparent.call_deferred(get_tree().root)