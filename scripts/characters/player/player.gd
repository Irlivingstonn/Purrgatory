extends CharacterBody2D

@export var move_speed : float = 100
@export var sprint_speed : float = 200
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/PlayerStates/playback")

var can_move : bool = true

func _ready():
	add_to_group("player")
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	update_animation_parameters(starting_direction)
	
func _on_spawn(position: Vector2): # , direction: String
	global_position = position
	# animation_tree.find_animation("move_" + direction)
	
	
	
	
func _physics_process(_delta):
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
	# Updates velocity
	if (Input.get_action_strength("sprint")):
		velocity = input_direction * sprint_speed
	else:
		velocity = input_direction * move_speed
	
	
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()
	
	pick_new_state()
	
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/PlayerStates/walk/blend_position", move_input)
		animation_tree.set("parameters/PlayerStates/idle/blend_position", move_input)
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
		
	
	
	
