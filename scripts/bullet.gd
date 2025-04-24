extends Node2D

var speed = 300
var velocity = Vector2(1,0)
var resetter = true
var target:Vector2

func _ready():
	pass
	
func _process(_delta):
	target = get_global_mouse_position()
	if resetter:
		look_at(target)
		global_position += 1500 * velocity.rotated(rotation) * _delta
		resetter = false
	self.visible = true
	global_position += speed * velocity.rotated(rotation) * _delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
