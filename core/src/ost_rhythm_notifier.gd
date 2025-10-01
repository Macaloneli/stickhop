@tool
class_name OSTRhythmNotifier
extends RhythmNotifier


func _process(_delta: float) -> void:
	if not is_multiplayer_authority():
		set_process(false)
		return

	if OSTManager.instance == null or OSTManager.instance.stream == null:
		return

	bpm = OSTManager.instance.stream.get_bpm()
	audio_stream_player = OSTManager.instance
