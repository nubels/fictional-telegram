class_name SwordAbilityController extends Node

@export var sword_ability_scene: PackedScene

@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var spawn_timer: Timer = %SpawnTimer


func _ready() -> void:
	spawn_timer.timeout.connect(on_spawn_timer_timeout)


func on_spawn_timer_timeout() -> void:
	if not player: return
	
	var sword_ability_instance = sword_ability_scene.instantiate() as SwordAbility
	player.get_parent().add_child(sword_ability_instance)
	sword_ability_instance.global_position = player.global_position
