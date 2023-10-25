class_name GameCamera extends Camera2D

@export var camera_smoothing_factor = 20

@onready var player = get_tree().get_first_node_in_group("player") as Player



var target_position = Vector2.ZERO

func _ready() -> void:
	make_current()


func _process(delta: float) -> void:
	if not player: return
	
	target_position = player.global_position
	
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * camera_smoothing_factor))
