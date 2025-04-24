extends Node
var playerFacing:float
var spawnPoints = [-1]
var cloneParent
var player
var level = 1
var shake = false
var damage
var camera : Camera2D
var iframes : bool = false
var score : float = 0
var birdHP : float = 8
var slimeHP : float = 99
var lockLv1 : float = 1
var menuScene
var birdStatChange = true

func clone(scene, where):
	var instantiated = scene.instantiate()
	cloneParent.add_child(instantiated)
	instantiated.global_position = where
	return instantiated

func neg(number:float):
	if number >= 0:
		return true
	elif number < 0:
		return false
