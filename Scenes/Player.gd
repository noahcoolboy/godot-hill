extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 16
var jump_speed = 6
var velocity = Vector3()

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)

func get_input():
	velocity.x = 0
	velocity.z = 0
	if Input.is_action_pressed("move_forward"):
		velocity.z -= speed
		velocity.y = 0
	if Input.is_action_pressed("move_back"):
		velocity.z += speed
		velocity.y = 0
	if Input.is_action_pressed("strafe_left"):
		velocity.x -= speed
		velocity.y = 0
	if Input.is_action_pressed("strafe_right"):
		velocity.x += speed
		velocity.y = 0
	