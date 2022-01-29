extends KinematicBody

var input_vector = Vector3()
var working_velocity = Vector3()
var final_velocity = Vector3()
var movement_speed_multiplier = 1
var camera_mode = false
var last_collision = null
var colliding = false

func _ready():
	last_collision = KinematicCollision.new()
	pass

func _process(_delta):
	var temp = get_last_slide_collision()
	if(get_slide_count() != 0):
		colliding = true
		if (temp.collider_id != last_collision.collider_id):
			last_collision = temp
			temp.collider.get_parent().change_material()
	else:
		if(colliding == true):
			last_collision.collider.get_parent().revert_material()
			last_collision = KinematicCollision.new()
			colliding = false

	if (input_vector.z != 0):
		if(!self.is_on_floor()):
			$AnimationPlayer.play("Jump")
		else:
			$AnimationPlayer.play("RunForward")
	elif (input_vector.x < 0):
		if(!self.is_on_floor()):
			$AnimationPlayer.play("JumpLeft")
		else:
			$AnimationPlayer.play("RunLeft")
	elif(input_vector.x > 0):
		if(!self.is_on_floor()):
			$AnimationPlayer.play("JumpRight")
		else:
			$AnimationPlayer.play("RunRight")
	if(input_vector.x == 0 and input_vector.z == 0):
		if($AnimationPlayer.current_animation == "RunForward" or $AnimationPlayer.current_animation == "Jump"):
			$AnimationPlayer.play("Idle")
		if($AnimationPlayer.current_animation == "RunLeft" or $AnimationPlayer.current_animation == "JumpLeft"):
			$AnimationPlayer.play("IdleLeft")
		if($AnimationPlayer.current_animation == "RunRight" or $AnimationPlayer.current_animation == "JumpRight"):
			$AnimationPlayer.play("IdleRight")

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
			elif event.is_action_pressed("RUN"):
				movement_speed_multiplier += PlayerGlobals.run_speed
			elif event.is_action_pressed("JUMP"):
				if(self.is_on_floor()):
					final_velocity.y += PlayerGlobals.jump_speed
			#elif event.is_action_pressed("CROUCH"):
			#	$PlayerCamera.global_translate(Vector3(0, -0.6, 0))
			#elif event.is_action_pressed("INTERACT"):
			#	if currently_looking_at != null and holding_state == false:
			#		interact_with_object()
			#	elif holding_state == true:
			#		drop()
			elif event.is_action_pressed("CAMERA"):
				if(camera_mode == true):
					camera_mode = false
					$PlayerCamera.update_camera_view()
					$PlayerCamera.change_camera_mode("Perspective")
				else:
					camera_mode = true
					self.transform.basis = Basis()
					$PlayerCamera.change_camera_mode("Orthogonal")

		else: #Keyups
			if event.is_action_released("MOVE_BACKWARD"):
				input_vector.z = clamp((input_vector.z - 1), -1, 0)
			elif event.is_action_released("MOVE_FORWARD"):
				input_vector.z = clamp((input_vector.z + 1), 0, 1)
			elif event.is_action_released("MOVE_RIGHT"):
				input_vector.x = clamp((input_vector.x - 1), -1, 0)
			elif event.is_action_released("MOVE_LEFT"):
				input_vector.x = clamp((input_vector.x + 1), 0, 1)
			elif event.is_action_released("RUN"):
				movement_speed_multiplier -= PlayerGlobals.run_speed
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
	
	working_velocity = input_vector.normalized() * PlayerGlobals.move_speed * movement_speed_multiplier
	if(camera_mode == false):
		working_velocity = working_velocity.rotated(Vector3(0,1,0), deg2rad(self.rotation_degrees.y))
		working_velocity.y = final_velocity.y + -9.8 * delta
		final_velocity = move_and_slide(working_velocity, Vector3(0, 1, 0), false)
	else:
		working_velocity = working_velocity.rotated(Vector3(0,0,1), deg2rad(90))
		working_velocity = working_velocity.rotated(Vector3(1,0,0), deg2rad(90))
		working_velocity.x = final_velocity.x - -9.8 * delta
		final_velocity = move_and_slide(working_velocity, Vector3(0, 0, 1), false)
	

func respawn():
	$Sprite3D.alpha_cut = SpriteBase3D.ALPHA_CUT_DISABLED
	$RespawnTween.interpolate_property($Sprite3D, "opacity", 1.0, 0.0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$RespawnTween.start()
	$RespawnTimer.start()

func _on_RespawnTimer_timeout():
	self.global_transform = PlayerGlobals.spawn_point
	PlayerGlobals.respawning = false
	$RespawnTween.stop_all()
	$Sprite3D.opacity = 1
	$Sprite3D.alpha_cut = SpriteBase3D.ALPHA_CUT_OPAQUE_PREPASS
	$PlayerCamera.update_camera_view()
