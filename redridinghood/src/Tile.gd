extends Area2D

var tile_event: int
var event_pic = preload("res://assets/textures/View.png")
var is_written = false
var explored_tile = preload("res://assets/textures/ExploredTile.png")
var random = RandomNumberGenerator.new()
var new_position: Vector2

func _process(delta: float) -> void:
	if(is_written == false):
		print(str(self.name) + ": " + str(tile_event))
		is_written = true

func _on_Tile_area_entered(area: Area2D) -> void:
	PlayerVariables.can_move = false
	PlayerVariables.standing_on = self.name
	print("Standing on: " + str(PlayerVariables.standing_on))
	get_node("Sprite").set_texture(explored_tile)
	
	if(self.tile_event == 10 || self.tile_event == 20):
		if(self.tile_event == 10):
			var watchtower = load("res://assets/textures/Watchtower1.png")
			self.event_pic = watchtower
			get_tree().get_root().get_node("Game").get_node("View").set_texture(watchtower)
		else:
			var watchtower = load("res://assets/textures/Watchtower2.png")
			self.event_pic = watchtower
			get_tree().get_root().get_node("Game").get_node("View").set_texture(watchtower)
		$AnimationPlayer.play("CollRelease")
		
	elif(self.tile_event == 7 or self.tile_event == 14):
		var stray_root = load("res://assets/textures/StrayRoot.png")
		self.event_pic = stray_root
		get_tree().get_root().get_node("Game").get_node("View").set_texture(stray_root)
		
		random.randomize()
		var tile_num = random.randi_range(1, 20)
		new_position = get_tree().get_root().get_node("Game").get_node("Tiles").get_node("Tile"+str(tile_num)).get_global_position()
		$AnimationPlayer.play("Teleport")
		$AnimationPlayer.queue("CollRelease")
		
	elif(self.tile_event == 2 || self.tile_event == 4):
		if(self.tile_event == 2):
			var field = load("res://assets/textures/FlowerField.png")
			self.event_pic = field
			get_tree().get_root().get_node("Game").get_node("View").set_texture(field)
			print("HP:"+str(PlayerVariables.health))
			if(PlayerVariables.health != 2):
				if(PlayerVariables.health + PlayerVariables.gained_health != 2):
					PlayerVariables.gained_health += 1
					get_tree().get_root().get_node("Game").get_node("Basket").get_node("Flower").set_visible(true)
			print("HP:"+str(PlayerVariables.health)+" GHP: "+str(PlayerVariables.gained_health))
			$AnimationPlayer.play("CollRelease")
		else:
			var field = load("res://assets/textures/MushroomField.png")
			self.event_pic = field
			get_tree().get_root().get_node("Game").get_node("View").set_texture(field)
			print("HP:"+str(PlayerVariables.health))
			if(PlayerVariables.health != 2):
				if(PlayerVariables.health + PlayerVariables.gained_health != 2):
					PlayerVariables.gained_health += 1
					get_tree().get_root().get_node("Game").get_node("Basket").get_node("Mushroom").set_visible(true)
				
				print("HP:"+str(PlayerVariables.health)+" GHP: "+str(PlayerVariables.gained_health))
			$AnimationPlayer.play("CollRelease")
		
	elif(self.tile_event == 13):
		if(PlayerVariables.has_knife == false):
			PlayerVariables.wolf_seen = true
		var wolf = load("res://assets/textures/TheWolf.png")
		get_tree().get_root().get_node("Game").get_node("View").set_texture(wolf)
		self.event_pic = wolf
		$AnimationPlayer.play("CollRelease")
	
	else:
		random.randomize()
		var number = random.randi_range(1, 8)
		var obstacle = load("res://assets/textures/Obstacle"+str(number)+".png")
		get_tree().get_root().get_node("Game").get_node("View").set_texture(obstacle)
		self.event_pic = obstacle
		
		if(number == 6):
			PlayerVariables.has_knife = true
			$AnimationPlayer.play("CollRelease")
		else:
			$AnimationPlayer.play("Wait")
		
func _on_Tile_area_exited(area: Area2D) -> void:
	PlayerVariables.can_move = true
	print("Can move: " + str(PlayerVariables.can_move))

func collision_release():
	$CollisionShape2D.set_disabled(true)

func teleport():
	PlayerVariables.player_position = new_position

func dice():
	var dice_window = preload("res://src/DiceWindow.tscn").instance()
	get_parent().add_child(dice_window)

func _on_Area2D_area_entered(area: Area2D) -> void:
	get_tree().get_root().get_node("Game").get_node("View").set_texture(self.event_pic)
