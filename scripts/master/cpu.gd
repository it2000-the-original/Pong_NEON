extends KinematicBody2D

onready var ball = get_node("/root/master/ball")

# Height and width of the player platform
const p_height = 128
const p_width = 32

var x_position : float

var speed = 400 # Default speed

func _ready():

	x_position = position.x

func _process(delta):

	# Correct constantly the position to
	# prevent alterations hitting the ball
	position.x = x_position

	var movement = get_movement(delta)
	move_and_collide(movement)

func set_mode(mode):

	match mode:

		"easy"   : speed = 200
		"normal" : speed = 400
		"hard"   : speed = 800

		_: print("ERROR: This mode ", mode, " does not exist")

func get_movement(delta):

	var velocity = Vector2()

	if ball.velocity.x > 0: # Move the platform only if the ball is coming

		var dinst = abs(position.y - ball.position.y)

		# The effective velocity must not be at 100% when the vertival dinstance is small
		if   position.y < ball.position.y: velocity.y = clamp(+dinst / speed / delta, 0, +1)
		elif position.y > ball.position.y: velocity.y = clamp(-dinst / speed / delta, -1, 0)
			
	return velocity * speed * delta

############# Signals #############

func _on_master_show_pause_menu():

	set_process(false)

func _on_pause_menu_hidden_pause_menu():

	set_process(true)