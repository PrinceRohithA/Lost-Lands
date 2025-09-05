extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	player.animation_state.travel("idle")
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]


func physics_update(_delta: float) -> void:
	player.dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	player.animation_tree["parameters/idle/blend_position"] = player.facing_dir * Vector2(1, -1)
	
	if player.dir != Vector2.ZERO:
		player.facing_dir = player.dir
		if player.run:
			finished.emit(RUN, {"dir": player.facing_dir})
		else:
			finished.emit(WALK, {"dir": player.facing_dir})
	
	if Input.is_action_just_pressed("run"):
		if player.run == false:
			player.run = true
		else:
			player.run = false
