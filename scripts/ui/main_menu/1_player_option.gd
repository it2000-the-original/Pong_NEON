extends Label

# The args to use to instance the master scene
# if you selected one player mode

var args = {

	"players": 1,
	"cpu_mode": ""
}

signal show_mode_menu

func callback():

	emit_signal("show_mode_menu")
	get_parent().set_process(false)

############# Signals #############

func _on_difficolty_launch_one_player_mode(mode):

	args.cpu_mode = mode

	SceneManager.goto_scene("res://scenes/master.tscn", args)

func _on_difficolty_difficulty_menu_closed():

	get_parent().set_process(true)
