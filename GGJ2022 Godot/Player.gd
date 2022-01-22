extends KinematicBody

var input_vector = Vector3()
var working_velocity = Vector3()
var final_velocity = Vector3()

func _process(_delta):
	pass

func _unhandled_input(event):
	#This could be done a lot better, if actions are rebinded to/from mouse or keyboard, it should be handled by both.
	
	#Handle directional key input
	if event is InputEventKey and event.is_echo() == false:
		if event.is_pressed(): #Keydowns
			if event.is_action_pressed("MOVE_BACKWARD"):
				input_vector.z = clamp((input_vector.z + 1), 0, 1)
			elif event.is_action_pressed("MOVE_FORWARD"):
				input_vector.z = clamp((input_vector.z - 1), -1, 0)
			elif event.is_action_pressed("MOVE_RIGHT"):
				input_vector.x = clamp((input_vector.x + 1), 0, 1)
			elif event.is_action_pressed("MOVE_LEFT"):
				input_vector.x = clamp((input_vector.x - 1), -1, 0)
			#elif event.is_action_pressed("RUN"):
				#movement_speed_multiplier += PlayerGlobals.run_speed
			#elif event.is_action_pressed("JUMP"):
			#	if(self.is_on_floor()):
			#		final_velocity.y += PlayerGlobals.jump_speed
			#elif event.is_action_pressed("CROUCH"):
			#	$PlayerCamera.global_translate(Vector3(0, -0.6, 0))
			#elif event.is_action_pressed("INTERACT"):
			#	if currently_looking_at != null and holding_state == false:
			#		interact_with_object()
			#	elif holding_state == true:
			#		drop()

		else: #Keyups
			if event.is_action_released("MOVE_BACKWARD"):
				input_vector.z = clamp((input_vector.z - 1), -1, 0)
			elif event.is_action_released("MOVE_FORWARD"):
				input_vector.z = clamp((input_vector.z + 1), 0, 1)
			elif event.is_action_released("MOVE_RIGHT"):
				input_vector.x = clamp((input_vector.x - 1), -1, 0)
			elif event.is_action_released("MOVE_LEFT"):
				input_vector.x = clamp((input_vector.x + 1), 0, 1)
			#elif event.is_action_released("RUN"):
			#	movement_speed_multiplier -= PlayerGlobals.run_speed
			#elif event.is_action_released("CROUCH"):
			#	$PlayerCamera.global_translate(Vector3(0, 0.6, 0))
			

func _input(event):
	#Mouse events seems to work with _input, but not _unhandled_input
	#Current reason unknown, could do with investiagating.
	
	if event is InputEventMouseButton: #and event.is_echo() == false:
		if event.is_pressed(): #Buttondowns
			if event.is_action_pressed("ZOOM_IN"):
				$PlayerCamera.fov -= 30
		
		else: #Buttonups
			if event.is_action_released("ZOOM_IN"):
				$PlayerCamera.fov += 30

func _physics_process(delta):
	
	working_velocity = input_vector.normalized()
	working_velocity = working_velocity.rotated(Vector3(0,1,0), deg2rad($PlayerCamera.rotation_degrees.y))
	working_velocity.y = final_velocity.y + -9.8 * delta
	final_velocity = move_and_slide(working_velocity, Vector3(0, 1, 0), true)
