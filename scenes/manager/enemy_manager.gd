class_name EnemyManager extends Node

@export var rat_enemy_scene: PackedScene

@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var player = get_tree().get_first_node_in_group("player") as Player

var spawn_radius = (ProjectSettings.get_setting("display/window/size/viewport_width") / 2) + 50

func _ready() -> void:
	enemy_spawn_timer.timeout.connect(on_enemy_spawn_timer_timeout)


func on_enemy_spawn_timer_timeout() -> void:
	if not player: return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * spawn_radius)
	
	var enemy_instance = rat_enemy_scene.instantiate() as RatEnemy
	get_parent().add_child(enemy_instance)
	enemy_instance.global_position = spawn_position
