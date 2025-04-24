extends CharacterBody2D

var speed : float = 100
var accel : float = 480
var decel : float = 500
var cooldown : bool = true
var dashDecelStart : bool = true
var dashCooldown : bool = false
var bulletScene : = preload("res://Scenes/bullet.tscn")
var hp : float = 10
@onready var trail = $Trail
@onready var glow = $Glow

func enable_bit(mask: int, index: int) -> int:
	return mask | (1 << index)

func disable_bit(mask: int, index: int) -> int:
	return mask & ~(1 << index)
	
#decel = deceleration
func dash(direction):
	if !dashCooldown:
		Global.camera.shake(0.1, 0.5)
		trail.emitting = true
		velocity = velocity.move_toward(direction * 300, 10000)
		Global.iframes = true
		$DashDecel.start()
		dashCooldown = true
		$DashCooldown.start()
		$iframes.start()
		if dashDecelStart:
			velocity = velocity.move_toward(direction, 40)
			$sounds/woosh.pitch_scale = randf_range(1.86, 2.2)
			$sounds/woosh.play()
			dashDecelStart = false
		
#gets the side of the viewport where the mouse is on
func mousex():
	var mousex : float = get_viewport().get_mouse_position().x
	var vpx : float = get_viewport_rect().size.x
	if mousex < vpx/2:
		return -1 #left
	else:
		return 1 #right
		
func _ready() -> void:
	#Engine.time_scale = 0.2
	$footsteps.start()
	match Global.level:
		1:
			glow.visible = false
	Global.player = self

func _exit_tree() -> void:
	Global.player = null
	
func _process(delta: float) -> void:
	mousex()
	
	$sounds/dirtStep.pitch_scale = randf_range(0.7, 1.3)
	
	#shooting
	if Input.is_action_pressed("LMouse") and cooldown or Input.is_action_pressed("Space") and cooldown:
		$sounds/gun.pitch_scale = randf_range(1.38, 1.72)
		$sounds/gun.play()
		Global.clone(bulletScene, global_position)
		cooldown = false
		$BulletCooldown.start()
	
	
	#print(mousex(), "  ", dashDecelStart, "  ", Input.is_action_just_pressed("LMouse"))
func _physics_process(_delta):
	var direction : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	
	#damage
	
	#handles dashing
	if Input.is_action_pressed("LShift") or Input.is_action_pressed("RMouse"):
		if direction != Vector2.ZERO:
			dash(direction)
		else:
			dash(Vector2(mousex(), 0))
	if direction != Vector2.ZERO:
		$sounds/dirtStep.volume_db = 5
		velocity = velocity.move_toward(direction * speed, accel * _delta)
	else:
		$sounds/dirtStep.volume_db = -100
		velocity = velocity.move_toward(Vector2.ZERO, decel * _delta)
		
	#flips player based on mousex's absolutity
	$Sprite.flip_h = !Global.neg(mousex())
	
	
	#if int(direction.x) * velocity.x < 0: 
		#$Sprite.play("Turn")
	#elif int(direction.x) > 0: 
		#$Sprite.play("Run")
		#$Sprite.flip_h = false
	#elif int(direction.x) < 0: 
		#$Sprite.play("Run")
		#$Sprite.flip_h = true

		

	move_and_slide()



func _on_bullet_cooldown_timeout() -> void:
	cooldown = true


func _on_dash_decel_timeout() -> void:
	
	dashDecelStart = true
	trail.emitting = false


func _on_dash_cooldown_timeout() -> void:
	dashCooldown = false


func _on_footsteps_timeout() -> void:
	#print("SHIT")
	$sounds/dirtStep.play()


func _on_iframes_timeout() -> void:
	Global.iframes = false
