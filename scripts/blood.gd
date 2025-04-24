extends Node2D
var spawnParticles = true
var fading = false
func _ready() -> void:
	$Blood.flip_h = Global.neg(randi_range(-2,1))
	$Blood.flip_v = Global.neg(randi_range(-2,1))

func _process(delta: float) -> void:
	var opac : float = $fade.time_left
	
	if spawnParticles:
		$CPUParticles2D.emitting = true
		spawnParticles = false
	if fading:
		self.modulate = Color(1, 1, 1, opac)

func _on_exist_timeout() -> void:
	fading = true
	$fade.start()


func _on_fade_timeout() -> void:
	queue_free()
	
