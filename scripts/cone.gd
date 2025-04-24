extends Node2D


@onready var playerScene = preload("res://scenes/player.tscn")
@onready var explosion = preload("res://scenes/airstrike.tscn")

var flash : bool = false
var health : float = 8
var blind = true

func _process(delta: float) -> void:
	if flash:
		modulate = Color(255, 255, 255, 100)
		
	else:
		modulate = Color.WHITE
		
	if health <= 0:
		Global.camera.shake(0.1, 2)
		Global.clone(explosion, global_position)
		queue_free()
	



func _on_flash_cooldown_timeout() -> void:
	flash = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("EDamage"):
		$sounds/hit.play()
		area.get_parent().queue_free()
		health -= Global.damage
		flash = true
		$flashCooldown.start()
