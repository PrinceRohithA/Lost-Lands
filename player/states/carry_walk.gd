extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	player.animation_state.travel("carry_walk")
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]


func physics_update(_delta: float) -> void:
	player.dir = Input.get_vector("left", "right", "up", "down")
	
	if player.dir != Vector2.ZERO:
		player.facing_dir = player.dir
		player.velocity = player.dir * player.walk_speed
		if player.run:
			finished.emit(CARRY_RUN, {"dir": player.facing_dir})
	else:
		finished.emit(CARRY_IDLE, {"dir": player.facing_dir})
		
	player.move_and_slide()
	
	player.animation_tree["parameters/carry_walk/blend_position"] = player.facing_dir * Vector2(1, -1)
	
	if Input.is_action_just_pressed("pick"):
		finished.emit(DROPPING, {"dir": player.facing_dir, "carry_item": player.carry_item})
