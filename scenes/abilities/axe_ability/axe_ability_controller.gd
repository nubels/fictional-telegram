class_name AxeAbilityController extends Node

@export var axe_ability_scene: PackedScene

@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
@onready var cooldown_timer: Timer = $CooldownTimer

var damage = 10

func _ready() -> void:
	cooldown_timer.timeout.connect(on_cooldown_timer_timeout)


func on_cooldown_timer_timeout() -> void:
	if not player: return
	if not foreground_layer: return
	
	var axe_ability_instance = axe_ability_scene.instantiate() as AxeAbility
	foreground_layer.add_child(axe_ability_instance)
	axe_ability_instance.global_position = player.global_position
	axe_ability_instance.hitbox_component.damage = damage
