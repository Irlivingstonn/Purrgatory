extends Node

const scene_kitchen := "res://scenes/environment/game/rooms/kitchen.tscn"
const scene_living_room := "res://scenes/environment/game/rooms/living_room.tscn"
const scene_pantry := "res://scenes/environment/game/rooms/pantry.tscn"
const scene_hallway_North := "res://scenes/environment/game/rooms/hallway_North.tscn"

signal on_trigger_player_spawn
var spawn_door_tag

func go_to_level(level_tag, destination_tag, Rooms, Tags): 
	# print("Level Tag: ", level_tag, " | Dest Tag: ", destination_tag )
	var scene_to_load
	
	# I definetly could code better than this
	# Pass in the array, set it up as a dictionary
	match level_tag:
		Rooms.KITCHEN:
			scene_to_load = scene_kitchen
		Rooms.LIVING_ROOM:
			scene_to_load = scene_living_room
		Rooms.HALLWAY_NORTH:
			scene_to_load = scene_hallway_North
		Rooms.PANTRY:
			scene_to_load = scene_pantry
		
			
	if scene_to_load != null:
		# if body.is_in_group("player"): <-- make the player stop moving
			
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = Tags.find_key(destination_tag)
		# get_tree().change_scene_to_packed(scene_to_load)
		get_tree().change_scene_to_file(scene_to_load)
		
func trigger_player_spawn(position: Vector2): # , direction: String
	on_trigger_player_spawn.emit(position) # , direction
