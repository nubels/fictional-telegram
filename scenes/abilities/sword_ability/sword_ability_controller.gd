class_name SwordAbilityController extends Node

@export var sword_ability_scene: PackedScene
@export var max_range := 125


@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var spawn_timer: Timer = %SpawnTimer


func _ready() -> void:
	spawn_timer.timeout.connect(on_spawn_timer_timeout)


func on_spawn_timer_timeout() -> void:
	if not player: return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	
	if enemies.size() == 0: return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	var closest_enemy = enemies[0] as Node2D
	
	var sword_ability_instance = sword_ability_scene.instantiate() as SwordAbility
	player.get_parent().add_child(sword_ability_instance)
	sword_ability_instance.global_position = closest_enemy.global_position 
	sword_ability_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = closest_enemy.global_position - sword_ability_instance.global_position
	sword_ability_instance.rotation = enemy_direction.angle()
