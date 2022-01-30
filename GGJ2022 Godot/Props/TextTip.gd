extends Spatial

export(String) var tip
export(bool) var billboard = true

func _ready():
	$Sprite3D.billboard = billboard
	var temp = load(tip)
	temp = temp.instance()
	$Viewport.add_child(temp)
	$Viewport.size = temp.rect_min_size
