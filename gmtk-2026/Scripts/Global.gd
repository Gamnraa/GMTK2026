extends Node

var ThePlayer = null
var TheScene = null
var TimeLeft = 22
var PauseTime = true

var score = 0
var level = 0
var is_ingame = false


var levels = ["tme_01.tscn", "tme_02.tscn"]

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
    level += 1
    TheScene.get_node("Level").get_child(0).free()
    var next_level = load("res://Nodes/Levels/debug_level2.tscn")
    TheScene.get_node("Level").add_child(next_level.instantiate())

func reset_player():
    ThePlayer.position = ThePlayer.start_pos
    ThePlayer.velocity = Vector2()
