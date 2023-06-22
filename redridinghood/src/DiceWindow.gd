extends Node2D

var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()
	var number = random.randi_range(1, 6)
	var texture = load("res://assets/textures/Dice"+str(number)+".png")
	$DiceSprite.set_texture(texture)

func die():
	get_tree().get_root().get_node("Game").get_node("Tiles").get_node(PlayerVariables.standing_on).get_node("CollisionShape2D").set_disabled(true)
	self.queue_free()
