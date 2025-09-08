extends PlayerState



var previous_state: String = IDLE


func enter(_previous_state: String, data: Dictionary = {}) -> void:
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]
		
	player.animation_tree["parameters/attack/blend_position"] = player.facing_dir * Vector2(1, -1)
	player.animation_state.travel("attack")
	previous_state = _previous_state


func update(_delta: float) -> void:
	if !player.animation_state.get_current_node() == "attack":
		finished.emit(previous_state, {"dir": player.facing_dir})
