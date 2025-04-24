extends Node2D
@onready var mouse : Vector2 
func _process(delta: float) -> void:
	var vp = get_viewport_rect().size
	var mousevp = get_viewport().get_mouse_position()
	mouse = Vector2(mousevp.x - (vp.x / 2), mousevp.y - (vp.y / 2))
	$CanvasLayer.offset = Vector2(mouse.x * 0.05 + 600, mouse.y * 0.05 + 250) 
	
