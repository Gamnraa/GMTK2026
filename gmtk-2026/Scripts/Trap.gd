extends StaticBody2D
@export var speed = 20.0
@export var path = PathFollow2D



func _ready():
	$Sprite2D.play("Spinten")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if path is PathFollow2D: path.progress += speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.reset_player()


func _on_cooldown_timeout() -> void:
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("Starting")
	$AnimatedSprite2D.scale = Vector2(0.8, 0.8)
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "position", Vector2(0, -40), .15)
	await get_tree().create_timer(.17).timeout
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D.position = Vector2(0, 0)
	await get_tree().create_timer(.5).timeout
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("Active")
	$AnimatedSprite2D.scale = Vector2(1.7, 1.7)
	$Active.start()
	$Area2D.monitoring = true
	


func _on_active_timeout() -> void:
	$Cooldown.start()
	$Area2D.monitoring = false
	$AnimatedSprite2D.play("inactive")
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D.position = Vector2(0, 60)
	
	
