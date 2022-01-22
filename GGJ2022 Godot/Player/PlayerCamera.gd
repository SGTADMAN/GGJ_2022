extends Camera

var x_rotation #Camera Rotation
var y_rotation #Camera Rotation
var sensativity = 0.005
func _init():
	x_rotation = 0
	y_rotation = 0

func _input(event):
	
	if event is InputEventMouseMotion:
		x_rotation -= event.relative.x * sensativity
		y_rotation -= event.relative.y * sensativity
		y_rotation = clamp(y_rotation, deg2rad(-90), deg2rad(90))
		transform.basis = Basis()
		rotate_object_local(Vector3(0, 1, 0), x_rotation)
		rotate_object_local(Vector3(1, 0, 0), y_rotation)

func update_camera_view():
	transform.basis = Basis()
	rotate_object_local(Vector3(0, 1, 0), x_rotation)
	rotate_object_local(Vector3(1, 0, 0), y_rotation)
