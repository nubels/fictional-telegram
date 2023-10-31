class_name EnemyManager extends Node

@export var rat_enemy_scene: PackedScene
@export var arena_time_manager: ArenaTimeManager

@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var entities_layer = get_tree().get_first_node_in_group("entities_layer") as Node2D

var spawn_radius = (ProjectSettings.get_setting("display/window/size/viewport_width") / 2) + 50
var base_spawn_time = 0


func _ready() -> void:
	enemy_spawn_timer.timeout.connect(on_enemy_spawn_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
	
	base_spawn_time = enemy_spawn_timer.wait_time


func get_spawn_position() -> Vector2:
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = Vector2.ZERO
	
	for i in 4:
		spawn_position = player.global_position + (random_direction * spawn_radius)
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1 << 0)
		var collider_dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		
		if collider_dictionary.is_empty():
			break
		
		random_direction = random_direction.rotated(deg_to_rad(90))
	
	
	return spawn_position


func on_enemy_spawn_timer_timeout() -> void:
	if not player: return
	if not entities_layer: return
	
	enemy_spawn_timer.start()
	
	var enemy_instance = rat_enemy_scene.instantiate() as RatEnemy
	enemy_instance.global_position = get_spawn_position()
	entities_layer.add_child(enemy_instance)


func on_arena_difficulty_increased(difficulty: int) -> void:
	var time_off = min((.1 / 12) * difficulty, .3)
	print_debug(time_off)
	enemy_spawn_timer.wait_time = base_spawn_time - time_off
