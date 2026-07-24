extends Node2D

func _process(dt):
	if Global.is_ingame: Global.is_ingame = Global.TimeLeft > 0
	await get_tree().create_timer(.2).timeout
	
	if not Global.is_gameover:
		if Global.is_ingame: pass
		else:
			$Camera2D/Win.set_deferred("monitoring", false)
			Global.end_game(false)
			
	else:
		if Input.is_action_just_pressed("ui_accept"):
			$Player.process_mode = Node.PROCESS_MODE_DISABLED
			Global.restart_game()
			await get_tree().create_timer(.15).timeout
			$Player.process_mode = Node.PROCESS_MODE_PAUSABLE
			await get_tree().create_timer(.08).timeout
			$Camera2D/Win.set_deferred("monitoring", true)
			
		

func _on_win_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.level < Global.levels.size():
			Global.score += Global.TimeLeft * 10
			Global.TimeLeft = Global.TimeLeft + 4
			$Camera2D/Win.set_deferred("monitoring", false)
			var tween = get_tree().create_tween()
			$Player.process_mode = Node.PROCESS_MODE_DISABLED
			tween.tween_property($Camera2D, "position", Vector2(1600, 360), .33)
			tween.tween_property($Level.get_child(0), "position", Vector2(0, 1000), .07)
			await get_tree().create_timer(.41).timeout
			Global.level_transition()
			$Level.get_child(0).position = Vector2(0, 1000)
			$Player.position = Vector2($Player.start_pos.x, $Player.position.y)
			$Camera2D.position = Vector2(600, 360)
			tween = get_tree().create_tween()
			tween.tween_property($Level.get_child(0), "position", Vector2(0, 0), .16)
			await get_tree().create_timer(.15).timeout
			$Player.process_mode = Node.PROCESS_MODE_PAUSABLE
			await get_tree().create_timer(.08).timeout
			$Camera2D/Win.set_deferred("monitoring", true)

func _on_lose_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.reset_player()
