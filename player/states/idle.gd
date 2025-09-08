extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	player.animation_state.travel("idle")
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]


func physics_update(_delta: float) -> void:
	player.dir = Input.get_vector("left", "right", "up", "down")
	player.animation_tree["parameters/idle/blend_position"] = player.facing_dir * Vector2(1, -1)
	
	if player.dir != Vector2.ZERO:
		player.facing_dir = player.dir
		if player.run:
			finished.emit(RUN, {"dir": player.facing_dir})
		else:
			finished.emit(WALK, {"dir": player.facing_dir})
	
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
			player.carry_item = item.item
			item.call_deferred("queue_free")
			finished.emit(PICKING, {"dir": player.facing_dir, "carry_item": player.carry_item})
