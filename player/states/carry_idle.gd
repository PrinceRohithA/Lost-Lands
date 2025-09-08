extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	player.animation_state.travel("carry_idle")
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]
	
	if data.has("carry_item"):
		player.carry_item = data["carry_item"]
	
	var carry_item: Node = load(Global.FOOD_SCENE_LOCATION).instantiate()
	carry_item.position = player.carry_item_location.position
	player.add_child(carry_item)


func physics_update(_delta: float) -> void:
	player.dir = Input.get_vector("left", "right", "up", "down")
	player.animation_tree["parameters/carry_idle/blend_position"] = player.facing_dir * Vector2(1, -1)
	
	if player.dir != Vector2.ZERO:
		player.facing_dir = player.dir
		if player.run:
			finished.emit(CARRY_RUN, {"dir": player.facing_dir})
		else:
			finished.emit(CARRY_WALK, {"dir": player.facing_dir})
	
