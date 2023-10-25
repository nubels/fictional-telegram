class_name SwordAbilityController extends Node

@export var sword_ability_scene: PackedScene
@export var max_range := 125


@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
@onready var spawn_timer: Timer = %SpawnTimer

var damage = 5
var base_wait_time

func _ready() -> void:
	base_wait_time = spawn_timer.wait_time
	spawn_timer.timeout.connect(on_spawn_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


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
	
	foreground_layer.add_child(sword_ability_instance)
	sword_ability_instance.hitbox_component.damage = damage
	sword_ability_instance.global_position = closest_enemy.global_position 
	sword_ability_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = closest_enemy.global_position - sword_ability_instance.global_position
	sword_ability_instance.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id != "sword_rate": return
	
	var percent_reduction = current_upgrades.sword_rate.quantity * .1
	spawn_timer.wait_time = base_wait_time * (1 - percent_reduction)
	spawn_timer.start()
	
	print(spawn_timer.wait_time)
