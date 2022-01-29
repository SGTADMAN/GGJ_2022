extends Node

export(String) var area_spawn = "Tutorial"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	area_spawn = "Map/" + area_spawn + "/SpawnPoint"
	PlayerGlobals.spawn_point = get_node(area_spawn).global_transform
	$Player.global_transform = PlayerGlobals.spawn_point
	Engine.target_fps = 60
	Engine.iterations_per_second = 60

func _process(_delta):
	if($Player.translation.y < -5 and PlayerGlobals.respawning == false):
		PlayerGlobals.respawning = true
		$Player.respawn()
		print("Crap crap crap crap crap crap")
		
