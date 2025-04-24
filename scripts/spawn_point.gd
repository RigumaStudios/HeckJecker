extends Node2D


@onready var bird : = preload("res://scenes/birdEnemy.tscn")
@export var enemy = bird

func _ready() -> void:
	visible = false

func _on_delay_timeout() -> void:
	Global.clone(enemy, self.global_position)
	queue_free()
