extends NinePatchRect

var options = []
var index = 0

var text_color      = Color(1, 1, 1, 0.5)
var selection_color = Color(1, 1, 1, 1) 

# The sound that is played when you select a new option
onready var sound = get_node("selection")

signal hidden_pause_menu

func _ready():

	visible = false
	set_process(false)

	for option in $options.get_children():

		options.append(option)

func _process(delta):

	if Input.is_action_just_pressed("ui_down"):

		select_option(index + 1)
		sound.play()

	elif Input.is_action_just_pressed("ui_up"):

		select_option(index - 1)
		sound.play()

	elif Input.is_action_just_pressed("ui_cancel"): close()

	elif Input.is_action_just_pressed("ui_accept"):

		# The callback function is the function
		# that every option owns in its script
		options[index].callback()

func select_option(_index):

	index = _index % len(options)
	reset_colors()

	options[index].add_color_override("font_color", selection_color)

func close():

	visible = false;
	set_process(false)
	emit_signal("hidden_pause_menu")

func show():

	reset_colors()
	select_option(0)	
	set_process(true)
	visible = true

func reset_colors():

	# Set the default color to every option

	for node in options:

		node.add_color_override("font_color", text_color)

######################## Signals

func _on_master_show_pause_menu(): show()
