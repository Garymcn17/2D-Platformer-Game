extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_options_button_pressed():
	var options = load("Options.tscn").instance()
	get_tree().current_scene.add_child(options)

func _on_quit_button_pressed():
	get_tree().quit()
