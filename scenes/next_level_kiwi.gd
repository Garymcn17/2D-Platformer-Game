extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):

	var group = get_groups()
	if (group[0] == "Kiwi 1"):
		get_tree().change_scene_to_file("res://scenes/level2.tscn")
		print("inside level 2 trigger")
	if (group[0] == "Kiwi 2"):
		print("inside level 3 trigger")
		get_tree().change_scene_to_file("res://scenes/level3.tscn")
	
	#get_tree().change_scene_to_file("res://scenes/level2.tscn")
	
	pass # Replace with function body.
