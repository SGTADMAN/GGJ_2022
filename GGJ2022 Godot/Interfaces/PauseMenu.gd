extends Control


func _on_ResumeButton_pressed():
	get_parent().close_menu("pause")

func _on_ExitButton_pressed():
	get_tree().quit()
