class_name ArenaTimeManager extends Node

@export var end_screen_scene: PackedScene

@onready var arena_timer: Timer = $ArenaTimer

var arena_difficulty = 0
var previous_time = 0
var difficulty_interval = 5

signal arena_difficulty_increased(difficulty: int)

func _ready() -> void:
	previous_time = arena_timer.wait_time
	arena_timer.timeout.connect(on_arena_timer_timeout)


func _process(delta: float) -> void:
	var next_time_target = arena_timer.wait_time - ((arena_difficulty + 1) * difficulty_interval)
	if arena_timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)


func get_time_elapsed() -> float:
	return arena_timer.wait_time - arena_timer.time_left


func on_arena_timer_timeout() -> void:
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
