extends MeshInstance

export(bool) var type
export(bool) var destructible = false
export(float) var destruct_time = 1.0

var active_texture
var background_colour
var text_colour
var cracked = false

func _ready():
	$DestructTimer.wait_time = destruct_time
	if(type == true):
		self.set_surface_material(0,load("res://Assets/Black.tres"))
		if(destructible == true):
			active_texture = load("res://Assets/OutlineWhiteCracked.tres")
		else:
			active_texture = load("res://Assets/OutlineWhite.tres")
		background_colour = Color( 0, 0, 0, 0 )
		text_colour = Color(1,1,1)
	else:
		self.set_surface_material(0,load("res://Assets/White.tres"))
		if(destructible == true):
			active_texture = load("res://Assets/OutlineBlackCracked.tres")
		else:
			active_texture = load("res://Assets/OutlineBlack.tres")
		background_colour = Color( 1, 1, 1, 1 )
		text_colour = Color(0,0,0)

func change_material():
	material_override = active_texture
	EnvironmentGlobal.environment.background_color = background_colour
	InterfaceGlobal.change_theme_colour(text_colour)
	if(destructible and !cracked):
		$DestructTimer.start()
		cracked = true

func revert_material():
	if(cracked == false):
		material_override = null

func _on_DestructTimer_timeout():
	if(cracked == true):
		self.visible = false
		$StaticBody.collision_mask = 0
		$StaticBody.collision_layer = 0
		$DestructTimer.wait_time = 3.0
		$DestructTimer.start()
		cracked = false
	else:
		self.visible = true
		$StaticBody.collision_mask = 1
		$StaticBody.collision_layer = 1
		$DestructTimer.wait_time = destruct_time
		material_override = null
