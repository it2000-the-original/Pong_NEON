extends KinematicBody2D

const size = 32

const INITIAL_SPEED = 500 # The speed at witch the ball starts in every round
const SPEED_INCREMENT = 5 # The incrementation of the speed at every joke
const MAX_Y_VECTOR = 1

var speed = INITIAL_SPEED
var velocity = Vector2()

onready var player_1 = get_node("/root/master/player_1")
onready var player_2 = get_node("/root/master/player_2")

func _ready():

	randomize()

func _process(delta):

	var movement = velocity * speed * delta

	var collision = move_and_collide(movement)

	check_for_collisions(collision)

func start():

	$wait.start()

	position.x = 512
	position.y = 300

	velocity = Vector2()

	speed = INITIAL_SPEED

func check_for_collisions(collision):

	if collision != null:

		var collider = collision.collider

		if "wall" in collider.name:

			velocity = velocity.bounce(collision.normal)
			$animations.play("ball_bounce")
			$bounce.play()

		if "player_1" in collider.name: _on_player1_collision(collider)
		if "player_2" in collider.name: _on_player2_collision(collider)

func set_new_direction():

	var new_velocity = Vector2()

	if randi() % 2: 
		new_velocity.x = +1;
	else:
		new_velocity.x = -1;

	new_velocity.y = rand_range(-1, 1)

	velocity = new_velocity.normalized()

func _on_player1_collision(player):

	if position.x > player.position.x:

		# Use the distance to calculate the angle of bounce of the ball
		var dist = position.y - player.position.y
		position.x = player.position.x + (player.p_width + size) / 2

		velocity.x = 1
		velocity.y = (dist / (player.p_height / 2)) * MAX_Y_VECTOR
		velocity = velocity.normalized()
		speed += SPEED_INCREMENT

		$animations.play("ball_bounce")
		player_1.get_node("animations").play("ball_bounce")
		$bounce.play()

	else: position.x = player.position.x - (player.p_width + size) / 2

func _on_player2_collision(player):

	if position.x < player.position.x:

		var dist = position.y - player.position.y
		position.x = player.position.x - (player.p_width + size) / 2
		
		velocity.x = -1
		velocity.y = (dist / (player.p_height / 2)) * MAX_Y_VECTOR
		velocity = velocity.normalized()
		speed += SPEED_INCREMENT

		$animations.play("ball_bounce")
		player_2.get_node("animations").play("ball_bounce")
		$bounce.play()

	else: position.x = player.position.x + (player.p_width + size) / 2

############# Signals #############

func _on_Wait_timeout():

	set_new_direction()

func _on_pause_menu_hidden_pause_menu():

	$wait.paused = false
	set_process(true)

func _on_master_show_pause_menu():

	$wait.paused = true
	set_process(false)
