extends CharacterBody2D


@onready var playerScene = preload("res://scenes/player.tscn")
@onready var explosion = preload("res://scenes/airstrike.tscn")
@onready var blood = preload("res://scenes/blood.tscn")

var speed : float = 20
var accel : float = 100
var flash : bool = false
var health : float = Global.slimeHP
var blind = true
var setHealth = true
func changeStats():
	health = Global.slimeHP

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _ready() -> void:
	SignalBus.enemyDataChanged.connect(changeStats)

func _process(delta: float) -> void:
	print(blind)
	if setHealth or Global.birdStatChange:
		changeStats()
	if !flash:
		var direction = global_position.direction_to(Global.player.global_position) if !blind else Vector2.ZERO
		velocity = direction * speed
		$Sprite.flip_h = !Global.neg(direction.x)
	if Global.iframes:
		set_collision_mask_value(1, false)
		
	elif !Global.iframes:
		set_collision_mask_value(1, true)
		
	move_and_slide()
	
	
	
	if flash:
		modulate = Color(255, 255, 255, 100)
		
	else:
		modulate = Color.WHITE
		
	if health <= 0:
		Global.camera.shake(0.1, 2)
		Global.clone(blood, global_position)
		Global.clone(explosion, global_position)
		Global.score += 1
		queue_free()
	

func _on_bird_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("EDamage"):
		Global.birdStatChange = false
		blind = false
		setHealth = false
		$sounds/hit.play()
		area.get_parent().queue_free()
		health -= Global.damage
		flash = true
		$flashCooldown.start()		
		


func _on_flash_cooldown_timeout() -> void:
	flash = false
	


func _on_vision_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerSpot"):
		blind = false


func _on_vision_area_exited(area: Area2D) -> void:
	if area.is_in_group("playerSpot"):
		blind = true
