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
		get_parent().transform.basis = Basis()
		#rotate_object_local(Vector3(0, 1, 0), x_rotation)
		#rotate_object_local(Vector3(1, 0, 0), y_rotation)
		get_parent().rotate_object_local(Vector3(0, 1, 0), x_rotation)
		#get_parent().rotate(Vector3(1, 0, 0), y_rotation)

func change_camera_mode(type):
	if type == "Perspective":
		self.translation = Vector3(0,0.7,1.8)
		self.rotation_degrees = Vector3(0,0,0)
		self.set_process_input(true)
		projection = PROJECTION_PERSPECTIVE
	elif type == "Orthogonal":
		self.translation = Vector3(-10,0,0)
		self.rotation_degrees = Vector3(0,-90,0)
		self.size = 10
		self.set_process_input(false)
		projection = PROJECTION_ORTHOGONAL
	else:
		push_error("Not a camera type")
		assert(false)

func update_camera_view():
	transform.basis = Basis()
	get_parent().rotate_object_local(Vector3(0, 1, 0), x_rotation)
	#rotate_object_local(Vector3(1, 0, 0), y_rotation)
