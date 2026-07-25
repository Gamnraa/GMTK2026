extends StaticBody2D
@export var speed = 20
@export var path = PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if path is PathFollow2D: path.progress += speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.reset_player()


func _on_cooldown_timeout() -> void:
	await get_tree().create_timer(.5).timeout
	$Active.start()
	$Area2D.monitoring = true
	#play anim


func _on_active_timeout() -> void:
	$Cooldown.start()
	$Area2D.monitoring = false
	#unplay anim
	
