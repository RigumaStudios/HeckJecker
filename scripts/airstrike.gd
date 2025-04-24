extends Node2D
var strength : float = 3
func _ready() -> void:
	$AnimatedSprite2D.play("bigger")
	$explode.play()
	$explode2.play()
	
func _process(delta: float) -> void:
	$PointLight2D.energy = $Timer.time_left * strength
