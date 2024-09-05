extends VBoxContainer

var options = [] # List of label's nodes
var index = 0    # First option selected

onready var sound = get_node("../../selection")

func _ready():

	for node in get_children(): if node.visible:
			
		options.append(node)

	select_option(0)

func _process(delta):

	if Input.is_action_just_pressed("ui_down"):

		select_option(index + 1)
		sound.play()

	if Input.is_action_just_pressed("ui_up"):

		select_option(index + 1)
		sound.play()

	if Input.is_action_just_pressed("ui_accept"):

		options[index].callback()

func select_option(_index):

	index = _index % len(options)
	reset_colors()

	var color = Color(1, 1, 1, 1)

	options[index].add_color_override("font_color", color)


func reset_colors():

	for node in options:

		var color = Color(1, 1, 1, 0.5)
		node.add_color_override("font_color", color)
