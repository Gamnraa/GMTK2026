extends "res://Scripts/Trap.gd"
@export var delay = 0.0

func _ready() -> void:
	$AnimatedSprite2D.hide()
	await get_tree().create_timer(delay).timeout
	_on_cooldown_timeout()
