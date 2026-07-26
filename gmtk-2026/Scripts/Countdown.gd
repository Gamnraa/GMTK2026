extends Control
var current_val = 0
var first_place = "0"
var second_place = "0"
var tweening = false


func update_vals():
	current_val = str(Global.TimeLeft)
	if Global.TimeLeft > 9:
		first_place = current_val[0]
		second_place = current_val[1]
	else:
		first_place = "0"
		second_place = current_val[0]
	
	$Count/First/Mid.text = first_place
	$Count/First.text = str(clamp(first_place.to_int() + 1, 0, 9))
	$Count/First/Top.text = str(clamp(first_place.to_int() - 1, 0, 9))
	$Count/First.offset_transform_position = Vector2()
	
	$Count/Second/Mid.text = second_place
	$Count/Second.text = str(clamp(second_place.to_int() + 1, 0, 9))
	$Count/Second/Top.text = str(clamp(second_place.to_int() - 1, 0, 9))
	$Count/Second.offset_transform_position = Vector2()
	

func _ready():
	update_vals()
	
func _process(dt):
	if Global.TimeLeft > current_val.to_int() and not tweening:
		increment()
		tweening = true
	elif Global.TimeLeft < current_val.to_int() and not tweening:
		decrement()
		tweening = true

func increment():
	var offset = 0
	var tween = get_tree().create_tween()
	if second_place == "9":
		offset = .09
		tween.tween_property($Count/First, "offset_transform_position", Vector2(0, -18.475), .07)
	tween.tween_property($Count/Second, "offset_transform_position", Vector2(0, -18.475), .12)
	
	await get_tree().create_timer(.14 + offset).timeout
	tweening = false
	update_vals()
	
func decrement():
	var offset = 0
	var tween = get_tree().create_tween()
	if second_place == "0":
		offset = .09
		tween.tween_property($Count/First, "offset_transform_position", Vector2(0, 15.250), .07)
	tween.tween_property($Count/Second, "offset_transform_position", Vector2(0, 15.250), .12)
	
	await get_tree().create_timer(.14 + offset).timeout
	tweening = false
	update_vals()


func _on_timer_timeout() -> void:
	
	if Global.is_ingame:
		Global.TimeLeft = max(0, Global.TimeLeft - 1)
