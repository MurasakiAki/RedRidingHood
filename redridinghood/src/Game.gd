extends Node2D

var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
var tile_number = 1
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while tile_number < 29:
		random.randomize()
		var index = random.randi_range(0, array.size()-1)
		print("Index: "+str(index))
		var tile = get_node("Tiles").get_node("Tile"+str(tile_number))
		tile.tile_event = array[index]
		array.remove(index)
		tile_number += 1

func _process(delta: float) -> void:
	health_visual()
	
	if(PlayerVariables.has_knife == true):
		get_tree().get_root().get_node("Game").get_node("Basket").get_node("Knife").set_visible(true)

func health_visual():
	if(PlayerVariables.health == 1):
		get_tree().get_root().get_node("Game").get_node("Basket").get_node("Pie").set_visible(false)
	if(PlayerVariables.health == 0):
		get_tree().get_root().get_node("Game").get_node("Basket").get_node("Wine").set_visible(false)
	if(PlayerVariables.health < 0 or PlayerVariables.gained_health < 0):
		death_screen()

func death_screen():
	get_tree().get_root().get_node("Game").get_node("AnimationPlayer").play("Death")

func restart():
	get_tree().change_scene("res://src/Menu.tscn")
