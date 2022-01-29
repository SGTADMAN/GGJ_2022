extends WorldEnvironment

func _ready():
	environment.adjustment_enabled = true
	EnvironmentGlobal.environment = environment
