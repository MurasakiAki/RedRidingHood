extends Area2D

func _on_Finish_area_entered(area: Area2D) -> void:
	PlayerVariables.can_move = false
	$AnimationPlayer.play("Ending")
	

func ending():
	get_tree().change_scene("res://src/End.tscn")
