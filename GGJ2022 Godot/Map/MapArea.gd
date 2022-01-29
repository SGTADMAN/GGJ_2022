extends Spatial


func _on_Area_body_entered(body):
	PlayerGlobals.spawn_point = $SpawnPoint.global_transform
