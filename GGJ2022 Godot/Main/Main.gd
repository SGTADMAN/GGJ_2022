extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	PlayerGlobals.spawn_point = $SpawnPoint.global_transform
	Engine.target_fps = 60
	Engine.iterations_per_second = 60

func _process(_delta):
	if($Player.translation.y < -5 and PlayerGlobals.respawning == false):
		PlayerGlobals.respawning = true
		$Player.respawn()
		print("Crap crap crap crap crap crap")
		
