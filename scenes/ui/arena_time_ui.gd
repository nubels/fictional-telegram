class_name AreaTimeUI extends CanvasLayer

@export var area_time_manager: ArenaTimeManager

@onready var label: Label = %Label


func _process(delta: float) -> void:
	if not area_time_manager: return
	
	label.text = format_seconds_to_string(area_time_manager.get_time_elapsed())


func format_seconds_to_string(seconds: float) -> String:
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
