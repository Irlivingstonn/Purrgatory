extends Node2D

func _ready() -> void:
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
enum Tags { North, South, West, East }

func _on_level_spawn(destination_tag):
	var door_path = "Doors/door_" + destination_tag
	var door = get_node(door_path) as Door
	# print("Pos: ", door.spawn.global_position, " Spawn Dir: ", door.spawn_direction)
	# position: Vector2, direction: String
	NavigationManager.trigger_player_spawn(door.spawn.global_position) # , door.spawn_direction
