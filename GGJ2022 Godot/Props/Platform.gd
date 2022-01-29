extends MeshInstance

export(bool) var type

var active_texture
var background_colour

func _ready():
	if(type == true):
		self.set_surface_material(0,load("res://Assets/Black.tres"))
		active_texture = load("res://Assets/OutlineWhite.tres")
		background_colour = Color( 0, 0, 0, 0 )
	else:
		self.set_surface_material(0,load("res://Assets/White.tres"))
		active_texture = load("res://Assets/OutlineBlack.tres")
		background_colour = Color( 1, 1, 1, 1 )

func change_material():
	material_override = active_texture
	EnvironmentGlobal.environment.background_color = background_colour

func revert_material():
	material_override = null
