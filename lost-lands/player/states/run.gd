extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	player.animation_state.travel("run")
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]


func physics_update(_delta: float) -> void:
	player.dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if player.dir != Vector2.ZERO:
		player.facing_dir = player.dir
		player.velocity = player.dir * player.run_speed
		
		if !player.run:
			finished.emit(IDLE, {"dir": player.facing_dir})
		
		player.move_and_slide()
		
	else:
		finished.emit(IDLE, {"dir": player.facing_dir})
	
	player.animation_tree["parameters/run/blend_position"] = player.facing_dir * Vector2(1, -1)
	
	if Input.is_action_just_pressed("run"):
		if player.run == false:
			player.run = true
		else:
			player.run = false
