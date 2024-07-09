extends Control

@onready var label = $CanvasLayer/Label

func _ready():
	if Global.high_score == 10000:
		label.text = "High Score: N/A"
	else:
		label.text = "High Score: " + str(Global.high_score) + " seconds"

func _on_play_pressed():
	var _k = get_tree().change_scene_to_file("res://Scenes/Main.tscn")
