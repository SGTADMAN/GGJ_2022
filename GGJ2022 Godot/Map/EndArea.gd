extends Area

var fade = 0

func _on_EndArea_body_entered(body):
	$EndTimer.start()

func _on_EndTimer_timeout():
	if(!fade):
		$EndText.show()
		$EndTimer.start()
		fade = fade + 1
	elif(fade == 1):
		$Tween.interpolate_property($ColorRect, "color", Color(0.35, 0.35, 0.35, 0), Color(0.35, 0.35, 0.35, 1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN )
		$Tween.start()
		fade = fade + 1
	elif(fade == 2):
		fade = 0
		$EndText.hide()
		$Tween.stop_all()
		$EndTimer.stop()
		$ColorRect.color =  Color(0.35, 0.35, 0.35, 0)
		InterfaceGlobal.interface.open_menu("landing")
		MainGlobal.main.restart()
		
