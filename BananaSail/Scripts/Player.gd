extends CharacterBody3D

@onready var animation_player = $AnimationPlayer
@onready var banana = $Banana
@onready var particles = $Particles
@onready var audio_stream_player = $AudioStreamPlayer
const tilt_amount = PI/4
const rotation_speed = PI/2
const speed = 20
var vel
var disabled = true

func _ready():
	animation_player.play("Bob")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if disabled:
		return
	if Input.is_action_just_pressed("LockIn"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("LockOut"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	vel = Vector3.ZERO
	particles.emitting = false
	
	if Input.is_action_pressed("TiltLeft"):
		banana.rotation.z = lerp_angle(banana.rotation.z, -tilt_amount, 7 * delta)
		rotate_y(rotation_speed * delta)
		particles.emitting = true
	else:
		banana.rotation.z = lerp_angle(banana.rotation.z, 0, 7 * delta)
		
	if Input.is_action_pressed("TiltRight"):
		banana.rotation.z = lerp_angle(banana.rotation.z, tilt_amount, 7 * delta)
		rotate_y(-rotation_speed * delta)
		particles.emitting = true
	else:
		banana.rotation.z = lerp_angle(banana.rotation.z, 0, 7 * delta)
	
	if Input.is_action_pressed("Forward"):
		vel = transform.basis * Vector3.FORWARD * speed * -1
		particles.emitting = true
	if Input.is_action_pressed("Backward"):
		vel = transform.basis * Vector3.BACK * speed * -1
		particles.emitting = true
		
	if Input.is_action_pressed("Sprint"):
		vel *= 2
	
	if particles.emitting:
		audio_stream_player.volume_db = lerp(audio_stream_player.volume_db, -20.0, 7 * delta)
	else:
		audio_stream_player.volume_db = lerp(audio_stream_player.volume_db, -80.0, 2 * delta)
		
	set_velocity(vel)
	set_up_direction(Vector3.UP)
	move_and_slide()
	vel = velocity
	position.y = 0
