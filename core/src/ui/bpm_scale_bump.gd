extends Label

@export var rhythm_notifier: RhythmNotifier


func _ready() -> void:
	rhythm_notifier.beat.connect(_bump)


func _process(delta: float) -> void:
	rotation += 0.007 * delta


func _bump(_beat: int):
	$AnimationPlayer.stop()
	$AnimationPlayer.play("bump")
