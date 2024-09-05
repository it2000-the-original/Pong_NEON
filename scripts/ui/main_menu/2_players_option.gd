extends Label

# The args to use to instance the master scene
# if you selected two players mode

var args = {

	"players": 2
}

func callback():

	SceneManager.goto_scene("res://scenes/master.tscn", args)
