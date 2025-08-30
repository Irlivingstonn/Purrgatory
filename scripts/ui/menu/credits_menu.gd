extends Control

func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		print("Going back to main menu")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
