@tool
class_name OSTRhythmNotifier
extends RhythmNotifier


func _process(_delta: float) -> void:
	if OSTManager.stream == null:
		return

	bpm = OSTManager.stream.get_bpm()
	audio_stream_player = OSTManager.instance
