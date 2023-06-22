extends Button

var random = RandomNumberGenerator.new()
var was_pressed = false

func _on_RollButton_pressed() -> void:
	if(was_pressed == false):
		random.randomize()
		var number = random.randi_range(1, 6)
		var texture = load("res://assets/textures/Dice"+str(number)+".png")
		get_parent().get_node("DiceSprite").set_texture(texture)
		
		if(number % 2 == 0):
			get_parent().get_node("AnimationPlayer").play("Die")
		else:
			if(PlayerVariables.health == 0):
				PlayerVariables.gained_health -= 1
				if(PlayerVariables.gained_health == 0):
					get_tree().get_root().get_node("Game").get_node("Basket").get_node("Flower").set_visible(false)
					get_tree().get_root().get_node("Game").get_node("Basket").get_node("Mushroom").set_visible(false)
				elif(PlayerVariables.gained_health == 1):
					get_tree().get_root().get_node("Game").get_node("Basket").get_node("Mushroom").set_visible(false)
			else:
				PlayerVariables.health -= 1
			get_parent().get_node("AnimationPlayer").play("Die")
		
		was_pressed = true
