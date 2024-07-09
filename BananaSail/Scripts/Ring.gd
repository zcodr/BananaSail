extends StaticBody3D

@onready var main = $".."
@onready var audio_stream_player_3d = $AudioStreamPlayer3D
@onready var collision_shape = $CollisionShape3D
@onready var collision_shape_2 = $CollisionShape2

func _on_Hole_area_entered(body):
	if body.name == "Middle" and visible:		
		main.rings_left -= 1
		visible = false
		collision_shape.set_deferred("disabled", true)
		collision_shape_2.set_deferred("disabled", true)
		audio_stream_player_3d.play()

func _on_AudioStreamPlayer3D_finished():
	queue_free()
