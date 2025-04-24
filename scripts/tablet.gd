extends Control
@onready var pauseState : bool
@onready var birdScene = preload("res://scenes/birdEnemy.tscn")
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	hide()
	
func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	


func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()


func esc():
	if Input.is_action_just_pressed("Esc") and !pauseState:
		pause()
	elif Input.is_action_just_pressed("Esc") and pauseState:
		resume()
func _process(delta: float) -> void:
	Global.birdHP = float($bird.text)
	Global.slimeHP = float($slime.text)
	pauseState = get_tree().paused
	esc()



func _on_locks_text_changed(new_text: String) -> void:
	SignalBus.enemyDataChanged.emit()
	Global.birdStatChange = true
