extends Area2D

onready var ray = $RayCast2D

var health
var gained_health
var can_move
var standing_on
var tile_size = 80
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func _ready():
	PlayerVariables.can_move = true
	PlayerVariables.player_position = position
	PlayerVariables.player_position = position.snapped(Vector2.ONE * tile_size)
	PlayerVariables.player_position += Vector2.ONE * tile_size/2
	
	if(PlayerVariables.health == 2):
		get_tree().get_root().get_node("Game").get_node("Basket").get_node("Pie").set_visible(true)
		get_tree().get_root().get_node("Game").get_node("Basket").get_node("Wine").set_visible(true)
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func _process(delta: float) -> void:
	can_move = PlayerVariables.can_move
	standing_on = PlayerVariables.standing_on
	position = PlayerVariables.player_position
	health = PlayerVariables.health
	gained_health = PlayerVariables.gained_health
	

func move(dir):
	if(can_move == true):
		ray.cast_to = inputs[dir] * tile_size
		ray.force_raycast_update()
		if !ray.is_colliding():
			position += inputs[dir] * tile_size
			PlayerVariables.player_position = position
			print("Position"+str(position))
			print("PlayerPosition"+str(PlayerVariables.player_position))


