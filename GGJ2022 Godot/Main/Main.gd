extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	PlayerGlobals.spawn_point = $SpawnPoint.global_transform

func _process(_delta):
	if($Player.translation.y < -1 and PlayerGlobals.respawning == false):
		PlayerGlobals.respawning = true
		$Player.respawn()
		print("Crap crap crap crap crap crap")
