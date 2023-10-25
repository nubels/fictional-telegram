class_name ArenaTimeManager extends Node

@export var end_screen_scene: PackedScene

@onready var arena_timer: Timer = $ArenaTimer


func _ready() -> void:
	arena_timer.timeout.connect(on_arena_timer_timeout)


func get_time_elapsed() -> float:
	return arena_timer.wait_time - arena_timer.time_left


func on_arena_timer_timeout() -> void:
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
