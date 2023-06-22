extends Node2D

var is_good_ending: bool
var already_played = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(PlayerVariables.wolf_seen == false and PlayerVariables.health + PlayerVariables.gained_health == 2):
		var good_ending = load("res://assets/textures/GoodEnding.png")
		$Ending.set_texture(good_ending)
		is_good_ending = true
	if(PlayerVariables.wolf_seen == false and PlayerVariables.health + PlayerVariables.gained_health != 2):
		var neutral_ending = load("res://assets/textures/NeutralEnding.png")
		$Ending.set_texture(neutral_ending)
		is_good_ending = true
	if(PlayerVariables.wolf_seen == true):
		var bad_ending = load("res://assets/textures/BadEnding.png")
		$Ending.set_texture(bad_ending)
		is_good_ending = false

func _process(delta: float) -> void:
	if(is_good_ending == true and already_played == false):
		$AnimationPlayer.queue("GoodEnding")
		already_played = true
	if(is_good_ending == false and already_played == false):
		$AnimationPlayer.queue("BadEnding")
		already_played = true
