extends Node3D

@onready var timer = $Timer
@onready var label = $CanvasLayer/Label
@onready var label_2 = $CanvasLayer/Label2
@onready var animation_player = $CanvasLayer/AnimationPlayer
@onready var player = $Player
const RING = preload("res://Scenes/Ring.tscn")
const ring_amount = 10
var rings_left = ring_amount

func _ready():
	randomize()
	for _i in range(ring_amount):
		var new_ring = RING.instantiate()
		add_child(new_ring)
		new_ring.position = Vector3(randf_range(-175, 175), 0, randf_range(-175, 175))
		new_ring.rotation = Vector3(0, randf_range(0, 2 * PI), 0)
	animation_player.play("Intro")

func _process(_delta):
	if snapped(10000 - timer.time_left, 0.001) == 10000:
		label.text = "0.000"
	else:
		label.text = str(snapped(10000 - timer.time_left, 0.001))
	label_2.text = str(rings_left)
	
	if rings_left <= 0:
		Global.score = snapped(10000 - timer.time_left, 0.001)
		if Global.score <= Global.high_score:
			Global.high_score = Global.score
		var _k = get_tree().change_scene_to_file("res://Scenes/FinishScreen.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Intro":
		timer.start()
		player.disabled = false
