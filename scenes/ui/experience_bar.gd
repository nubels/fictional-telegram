class_name ExperienceBar extends CanvasLayer

@export var experience_manager: ExperienceManager

@onready var progress_bar: ProgressBar = %ProgressBar

func _ready() -> void:
	experience_manager.experience_updated.connect(on_experience_updated)


func on_experience_updated(current_experience: float, target_experience: float) -> void:
	if target_experience == 0: return
	
	var percent = current_experience / target_experience
	
	progress_bar.value = percent
