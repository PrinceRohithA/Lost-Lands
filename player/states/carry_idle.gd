extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	player.animation_state.travel("carry_idle")
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]
	
	if data.has("carry_item"):
		player.carry_item = data["carry_item"]


func physics_update(_delta: float) -> void:
	player.dir = Input.get_vector("left", "right", "up", "down")
	player.animation_tree["parameters/carry_idle/blend_position"] = player.facing_dir * Vector2(1, -1)
	
	if player.dir != Vector2.ZERO:
		player.facing_dir = player.dir
		if player.run:
			finished.emit(CARRY_RUN, {"dir": player.facing_dir})
		else:
			finished.emit(CARRY_WALK, {"dir": player.facing_dir})
	
	if Input.is_action_just_pressed("pick"):
		finished.emit(DROPPING, {"dir": player.facing_dir, "carry_item": player.carry_item})
