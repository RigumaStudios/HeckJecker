extends Node2D
func _process(delta: float) -> void:
	
	var mouse : Vector2 = get_viewport().get_mouse_position()
	look_at(get_global_mouse_position())
	
