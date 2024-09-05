extends KinematicBody2D

var up_action   = "p1_up"   # Input action to use to go up
var down_action = "p1_down" # Input action to use to go down

# Height and width of the player platform
const p_height = 128
const p_width  = 32

var x_position : float

# The speed of the player when 
# you move it trough input
var speed = 800

func _init():

	x_position = position.x

func set_input_actions(up_a, down_a):

	# This function is useful i two players mode
	# when you have to set different action when you
	# use the same script for both players

	up_action = up_a
	down_action = down_a

func _process(delta):

	# This is to stabilize the player position
	# preventing that could be changed hitting the ball
	position.x = x_position

	var movement = get_velocity() * speed * delta
	move_and_collide(movement)

func get_velocity():

	var velocity = Vector2()

	if Input.is_action_pressed(up_action):   velocity.y -= 1
	if Input.is_action_pressed(down_action): velocity.y += 1

	return velocity

############# Signals #############

func _on_master_show_pause_menu():

	# Stop the process when the pause menu is called
	set_process(false)

func _on_pause_menu_hidden_pause_menu():

	# and enable it when it is closed
	set_process(true)
