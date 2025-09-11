extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	player.animation_state.travel("walk")
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]


func physics_update(_delta: float) -> void:
	player.dir = Input.get_vector("left", "right", "up", "down")
	
	if player.dir != Vector2.ZERO:
		player.facing_dir = player.dir
		player.velocity = player.dir * player.walk_speed
		if player.run:
			finished.emit(RUN, {"dir": player.facing_dir})
	else:
		finished.emit(IDLE, {"dir": player.facing_dir})
	
	player.animation_tree["parameters/walk/blend_position"] = player.facing_dir * Vector2(1, -1)
	
	player.move_and_slide()
	
	update_input()


func update_input() -> void:
	if Input.is_action_just_pressed("attack"):
		if player.current_tool == player.tools.SWORD:
			finished.emit(ATTACK, {"dir": player.facing_dir})
		elif player.current_tool == player.tools.AXE:
			finished.emit(AXE, {"dir": player.facing_dir})
		elif player.current_tool == player.tools.BUCKET:
			finished.emit(WATERING, {"dir": player.facing_dir})
		elif player.current_tool == player.tools.PICKAXE:
			finished.emit(PICKAXE, {"dir": player.facing_dir})
		elif player.current_tool == player.tools.FISHINGROD:
			finished.emit(FISHING, {"dir": player.facing_dir})
	
	if Input.is_action_just_pressed("pick"):
		var item = player.ray_cast.get_collider()
		if item != null:
			player.process_pick(item)
			finished.emit(PICKING, {"dir": player.facing_dir, "carry_item": player.carry_item})
