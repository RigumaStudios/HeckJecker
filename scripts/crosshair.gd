extends Node2D

func _process(delta: float) -> void:
	$CanvasLayer.offset = get_viewport().get_mouse_position()
