extends Control

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("CHANGE_TO_SPECIAL_SCENE"):
		get_tree().change_scene("res://scr/Levels/BdayLevel.tscn")
