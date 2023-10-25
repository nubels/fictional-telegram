class_name ArenaTimeManager extends Node

@onready var arena_time: Timer = $ArenaTime


func get_time_elapsed() -> float:
	return arena_time.wait_time - arena_time.time_left
