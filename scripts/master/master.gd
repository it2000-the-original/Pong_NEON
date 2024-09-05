extends Node

var p1_score = 0 # Player 1 score
var p2_score = 0 # Player 2 score

onready var music = get_node("sounds/music")

signal show_pause_menu

func _ready():

	set_labels_scores()
	$ball.start()

func init(args):

	if args.players == 1:

		$player_2.set_mode(args.cpu_mode)

	elif args.players == 2:

		# Add to the second platform a controlled player script
		var player_script = load("res://scripts/master/player.gd")
		$player_2.set_script(player_script)
		$player_2.set_input_actions("p2_up", "p2_down")

func _process(delta):

	if Input.is_action_just_pressed("ui_cancel"): pause()

func set_labels_scores():

	$background/p1_score.set_text(str(p1_score))
	$background/p2_score.set_text(str(p2_score))

func pause():

	emit_signal("show_pause_menu")
	music.stream_paused = true
	set_process(false)

############# Signals #############

func _on_door_1_body_exited(body):

	# This function is called when the ball
	# hit the door of the first player

	if "ball" in body.name:

		p2_score += 1
		$ball.start()
		set_labels_scores()
		$"sounds/goal".play()
		$"background/animations".play("p2_score_increase")

func _on_door_2_body_exited(body):

	# The same thing of the upper function
	# but with the door of the second player

	if "ball" in body.name:

		p1_score += 1
		$ball.start()
		set_labels_scores()
		$"sounds/goal".play()
		$"background/animations".play("p1_score_increase")

func _on_pause_menu_hidden_pause_menu():

	music.stream_paused = false
	set_process(true)

func _notification(what):

	if what == NOTIFICATION_WM_FOCUS_OUT: pause()
