extends Node2D

var doors: Array[DE]
var current_door_item: int = 0
var next_item: bool = true

var player_node: CharacterBody2D

func _ready() -> void:

	for i in get_tree().get_nodes_in_group("player"):
		player_node = i
		
func _process(delta: float) -> void:
	if current_door_item == doors.size():
		if !player_node:
			for i in get_tree().get_nodes_in_group("player"):
				player_node = i
			return
		player_node.can_move = true
		queue_free()
		return

    if next_item:
		next_item = false
		var i = doors[current_door_item]


        if i is DialogueFunction:
			if i.hide_dialogue_box:
				visible = false
				
			else:
				visible = true
			_function_resource(i)

        else:
			printerr("You accidentally added a DE resource!")
			current_dialogue_item += 1
			next_item