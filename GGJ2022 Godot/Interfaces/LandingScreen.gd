extends Control


func _on_StartButton_pressed():
	get_parent().close_menu("landing")

func _on_ExitButton_pressed():
	get_tree().quit()
