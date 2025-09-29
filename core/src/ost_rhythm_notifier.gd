extends RhythmNotifier
class_name OSTRhythmNotifier

func _process(_delta: float) -> void:
	if OSTController.stream == null:
		return
	
	bpm = OSTController.stream.get_bpm()
	audio_stream_player = OSTController
