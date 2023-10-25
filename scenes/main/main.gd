class_name Main extends Node

@export var end_screen_scene: PackedScene
@export var player: Player

func _ready() -> void:
	player.health_component.health_depleted.connect(on_player_health_depleted)


func on_player_health_depleted() -> void:
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
