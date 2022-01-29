extends "res://Props/Platform.gd"

var bounce = false
export(Vector3) var start_point = Vector3(0,0,0)
export(Vector3) var end_point = Vector3(0,0,0)
export(float) var duration = 1.0

func _ready():
	$Timer.wait_time = duration
	$Tween.interpolate_property(self, "translation", start_point, end_point, 1, Tween.TRANS_LINEAR, Tween.EASE_IN )
	$Tween.start()

func _process(_delta):
	pass

func _on_Timer_timeout():
	if(bounce == true):
		$Tween.interpolate_property(self, "translation", start_point, end_point, duration, Tween.TRANS_LINEAR, Tween.EASE_IN )
		bounce = false
	else:
		$Tween.interpolate_property(self, "translation", end_point, start_point, duration, Tween.TRANS_LINEAR, Tween.EASE_IN )
		bounce = true
