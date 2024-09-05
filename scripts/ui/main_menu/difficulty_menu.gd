extends NinePatchRect

var options = [] # List of options labels
var index = 0    # Current selected label

signal launch_one_player_mode
signal difficulty_menu_closed

onready var sound = get_node("../../selection")

func _ready():

	visible = false

	for node in $modes.get_children(): if node.visible:

		options.append(node)

	set_process(false)

func _process(delta):

	if Input.is_action_just_pressed("ui_down"):

		select_option(index + 1)
		sound.play()

	if Input.is_action_just_pressed("ui_up"):

		select_option(index - 1)
		sound.play()

	if Input.is_action_just_pressed("ui_accept"):

		emit_signal("launch_one_player_mode", options[index].get_text())

	if Input.is_action_just_pressed("ui_cancel"): close()

func select_option(_index):

	index = _index % len(options)
	reset_colors()

	var color = Color(1, 1, 1, 1)

	options[index].add_color_override("font_color", color)

func reset_colors():

	for node in options:

		var color = Color(1, 1, 1, 0.5)
		node.add_color_override("font_color", color)

func close():

	visible = false
	set_process(false)
	emit_signal("difficulty_menu_closed")

############# Signals #############

func _on_1_player_show_mode_menu():

	visible = true
	set_process(true)
	reset_colors()
	select_option(0)
