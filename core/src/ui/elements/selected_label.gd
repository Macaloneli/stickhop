extends Label

@export var button: BaseButton


func _process(_delta: float) -> void:
	visible = button.button_pressed
