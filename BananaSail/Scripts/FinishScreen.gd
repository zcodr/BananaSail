extends Control

@onready var label_2 = $CanvasLayer/Label2
@onready var label = $CanvasLayer/Label

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	label_2.text = "High Score: " + str(Global.high_score) + " seconds"
	label.text = "Score: " + str(Global.score) + " seconds"
	Global.save_app()
	
func _on_again_pressed():
	var _k = get_tree().change_scene_to_file("res://Scenes/Main.tscn")
