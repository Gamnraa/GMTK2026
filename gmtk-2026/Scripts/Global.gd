extends Node

var ThePlayer = null
var TheScene = null
var TimeLeft = 15
var PauseTime = false

var score = 0
var level = 0
var deaths = 0
var is_ingame = false
var is_gameover = false


var levels = ["01.tscn", "02.tscn"]

func _ready():
	var root = get_tree().get_root()
	TheScene = root.get_child(root.get_child_count() - 1)
	ThePlayer = TheScene.get_node("Player")
	
	
	
	await get_tree().create_timer(.1).timeout
	is_ingame = true
	
	#TheScene.appear()
	var next_level = load("res://Nodes/Levels/debug_level.tscn")
	
	if TheScene.get_node("Level").get_child(0): TheScene.get_node("Level").get_child(0).free()
	TheScene.get_node("Level").add_child(next_level.instantiate())

func level_transition():
	#score is updated in MainScene since we've already increased the time by the time this gets called
	level += 1
	TheScene.get_node("Level").get_child(0).free()
	var next_level = load("res://Nodes/Levels/debug_level2.tscn")
	TheScene.get_node("Level").add_child(next_level.instantiate())

func reset_player():
	ThePlayer.position = ThePlayer.start_pos
	ThePlayer.velocity = Vector2()
	deaths += 1
	
func end_game(won):
	score = floor(max(0, score / (deaths + 1)))
	if won: TheScene.get_node("EndScreen").get_node("Message").text = "You win!"
	else: TheScene.get_node("EndScreen").get_node("Message").text = "You lose!"
	
	TheScene.get_node("EndScreen").get_node("Score").text = "Final Score: " + str(score)
	TheScene.get_node("EndScreen").visible = true
	
	is_gameover = true
	
func restart_game():
	var next_level = load("res://Nodes/Levels/debug_level.tscn")
	
	if TheScene.get_node("Level").get_child(0): TheScene.get_node("Level").get_child(0).free()
	TheScene.get_node("Level").add_child(next_level.instantiate())
	
	level = 0
	TimeLeft = 15
	score = 0
	deaths = 0
	is_ingame = true
	is_gameover = false
	TheScene.get_node("EndScreen").visible = false
	ThePlayer.position = ThePlayer.start_pos
	ThePlayer.velocity = Vector2()
	
	
	
