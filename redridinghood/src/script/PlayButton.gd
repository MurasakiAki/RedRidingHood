extends Button

var game_scene = "res://src/Game.tscn"

func _on_PlayButton_pressed() -> void:
	PlayerVariables.set_script(null)
	var new_pv = preload("res://src/script/PlayerVariables.gd")
	PlayerVariables.set_script(new_pv)
	
	get_tree().change_scene(game_scene)
