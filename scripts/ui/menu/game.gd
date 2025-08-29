extends Control

func _on_play_pressed() -> void:
	print("play pressed")
	$Panel.visible = false
	$purrgatory.visible = false
	# $AnimationPlayer.play("zoom_to_door")
	#get_tree().change_scene_to_file("insert tscn file")


func _on_load_pressed() -> void:
	print("load pressed")


func _on_settings_pressed() -> void:
	print("settings pressed")
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")


func _on_credits_pressed() -> void:
	print("credits pressed")
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")


func _on_quit_pressed() -> void:
	print("quit pressed")
	get_tree().quit()
