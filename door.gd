extends Area2D

class_name Door

enum Rooms { KITCHEN = 0, LIVING_ROOM = 1, HALLWAY_NORTH = 2, PANTRY = 3, BEDROOM = 4}
enum Tags { North, South, West, East }
enum Directions { UP, DOWN, LEFT, RIGHT }

@export var destination_level_tag : Rooms
@export var destination_door_tag: Tags
@export var spawn_direction : Directions

@onready var spawn = $Spawn

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag, Rooms, Tags) # Rooms, Tags
