extends CanvasLayer

var pause_menu_state = false

func _ready():
	$PauseMenu.hide()

func _unhandled_input(event):
	if event is InputEventKey and event.is_echo() == false:
		if event.is_action_pressed("PAUSE"):
			open_menu("pause")

func open_menu(menu_type):
	get_parent().set_physics_process(false)
	set_process_input(false)
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if(menu_type == "pause"):
		$PauseMenu.show()

func close_menu(menu_type):
	get_parent().set_physics_process(true)
	set_process_input(true)
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if(menu_type == "pause"):
		$PauseMenu.hide()

func _on_ResumeButton_pressed():
	close_menu("pause")

func _on_ExitButton_pressed():
	get_tree().quit()

