extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
const DOUBLE_JUMP_VELOCITY = -550.0
const WALL_JUMP_VELOCITY = -750
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_doublejump = true
var can_walljump = true
var lives = 3


func _physics_process(delta):
	#Animations
	if (velocity.x > 1 || velocity.x  < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		can_doublejump = true
		can_walljump = true
		
	# Handle Wall Jump.
	if Input.is_action_just_pressed("jump") and is_on_wall() and not is_on_floor() and can_walljump:
		velocity.y = WALL_JUMP_VELOCITY
		can_walljump = false
		
	# Handle Double Jump.
	if Input.is_action_just_pressed("jump") and not is_on_floor() and can_doublejump:
		velocity.y = DOUBLE_JUMP_VELOCITY
		can_doublejump = false
	
	# Drop through platform code
	if Input.is_action_just_pressed("drop") and is_on_floor():
		position.y += 1
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)

	move_and_slide()
	var isLeft  = velocity.x < 0
	sprite_2d.flip_h = isLeft


func _on_area_2d__spikes_body_entered(body):
	print("You have died.")
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
	
	#if (lives > 0):
	#	lives -= 1
	#	get_tree().change_scene_to_file("res://scenes/main.tscn")
	#else:
	#	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
	
	
func _on_area_2d_body_entered(body):
	velocity.y -= 600
	pass # Replace with function body.


func fan_on_area_2d_2_body_entered(body):
	print("You have died.")
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")


func finish_node_entered(body):
	print("Game complete.")
	get_tree().change_scene_to_file("res://scenes/final_screen.tscn")


func saw_body_entered(body):
	print("You have died.")
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
