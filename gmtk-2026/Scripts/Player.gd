extends CharacterBody2D
var max_speed = 150
var ground_speed = 580
var air_speed = 360
var accel = 210
var jump_force = 892.4

var coyote_timer = 5
var coyote_timer_max = 5

var activated = true
var was_grounded = true

var start_pos = Vector2(0, 0)


func _ready():
	start_pos = position
	
func _physics_process(delta: float):
	var grounded = is_on_floor()
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	
	max_speed = ground_speed
	if not grounded:
		max_speed = air_speed
		velocity += get_gravity() * 0.037
		
	if !is_on_floor() and coyote_timer > 0:
		coyote_timer -= 1
	if is_on_floor():
		coyote_timer = coyote_timer_max
		
	if Input.is_action_pressed("right"):
		velocity.x = min(velocity.x + accel, max_speed)
		$Sprite.flip_h = false
		#if is_on_floor(): $Sprite2D/AnimationPlayer.play("player-walk")
		
	if Input.is_action_pressed("left"):
		velocity.x = max(velocity.x - accel, -max_speed)
		$Sprite.flip_h = true
		#if is_on_floor(): $Sprite2D/AnimationPlayer.play("player-walk")
		
	if (grounded or coyote_timer > 0) and Input.is_action_pressed("jump"):
		velocity.y = -jump_force
		#if move_buttons_pressed:
		if right: velocity.x += 350
		if left: velocity.x -= 350
		
	if not grounded and Input.is_action_pressed("ground_pound"):
		velocity.y = jump_force * 2
	
	if not (left or right) and grounded:
		velocity.x = move_toward(velocity.x, 0, accel)
		#$Sprite2D/AnimationPlayer.play("player-idle")
		
	if not was_grounded and grounded: 
		if velocity.x > 0: velocity.x -= accel / 2
		if velocity.x < 0: velocity.x += accel / 2
	was_grounded = grounded
	move_and_slide()
