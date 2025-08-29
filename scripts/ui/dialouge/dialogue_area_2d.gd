extends Area2D

const DialogueSystemPreload = preload("res://scenes/ui/dialouge/dialogue_system.tscn")

@export var activate_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var override_position: Vector2
@export var dialogue: Array[DE]

var cam_margin := 48
var offset := 1.85

var player_body_in: bool = false
var has_activated_already: bool = false
var desired_dialogue_pos: Vector2

var player_node: CharacterBody2D = null

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i

func _process(_delta: float) -> void:
	if !player_node:
		for i in get_tree().get_nodes_in_group("player"):
			player_node = i
		return
	
	if !activate_instant and player_body_in:
		if only_activate_once and has_activated_already:
			set_process(false)
			return

		if Input.is_action_just_pressed("ui_accept"):
			_activate_dialogue()
			player_body_in = false


func _activate_dialogue() -> void:
	print("ACTIVATE: making dialogue")

	player_node.can_move = false

	var new_dialogue = DialogueSystemPreload.instantiate()
	print("ACTIVATE: instance=", new_dialogue)
	
	
	var screen: Vector2 = get_viewport_rect().size
	var cam := get_viewport().get_camera_2d()
	var pos := get_viewport_rect().position
	var root := get_tree().root
	
	if override_dialogue_position:
		desired_dialogue_pos = override_position
	else:
		if player_node.global_position.y <= (get_viewport().get_camera_2d().get_screen_center_position().y + 1): # might need to change which camera will be used here (in the future)
			desired_dialogue_pos = Vector2(0, (cam_margin * offset)) +  cam.get_screen_center_position() # + (dialogue_bottom_pos * 0.5)

		else:
			desired_dialogue_pos = Vector2(0, (cam_margin * offset * -1)) + cam.get_screen_center_position() # + (dialogue_bottom_pos * 0.5)
			
	new_dialogue.global_position = desired_dialogue_pos
	new_dialogue.dialogue = dialogue
	get_parent().add_child(new_dialogue)


func _on_body_entered(body: Node2D) -> void:
	print("HANDLER: _on_body_entered, instant=", activate_instant, 
		  " only_once=", only_activate_once, " has=", has_activated_already)
	if only_activate_once and has_activated_already:
		return
	if body.is_in_group("player"):
		player_body_in = true
		if activate_instant:
			_activate_dialogue()
			

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_body_in = false
