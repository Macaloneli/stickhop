extends Node2D

@export var body: CharacterBody2D


func _ready() -> void:
	$AnimationPlayer.speed_scale = 2


func _process(delta: float) -> void:
	if body.is_on_floor() and body.velocity.x != 0:
		$AnimationPlayer.play("walk_right" if body.velocity.x > 0 else "walk_left")
	else:
		$AnimationPlayer.play("idle")
