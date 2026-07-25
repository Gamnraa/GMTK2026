extends "res://Scripts/Trap.gd"
@export var delay = 0

func _ready() -> void:
	await get_tree().create_time(delay).timeout
	_on_cooldown_timeout()
