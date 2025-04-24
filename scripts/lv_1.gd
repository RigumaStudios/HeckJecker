extends Node2D
var playOnce : bool = true
func _ready() -> void:
	Global.cloneParent = self
	
func _process(delta: float) -> void:
	Global.damage = 1
	if Global.score > 1 and playOnce:
		$musSquare/startDelay.start()
		playOnce = false


func _exit_tree() -> void:
	Global.cloneParent = null


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("EDamage"):
		#area.get_parent().queue_free()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("EDamage"):
		area.get_parent().queue_free()


func _on_start_delay_timeout() -> void:
	$musSquare.play(0)
