extends PlayerState



var previous_state: String = IDLE


func enter(_previous_state: String, data: Dictionary = {}) -> void:
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]
		
	player.animation_tree["parameters/fishingrod/blend_position"] = player.facing_dir * Vector2(1, -1)
	player.animation_state.travel("fishingrod")
	previous_state = _previous_state


func update(_delta: float) -> void:
	if Input.is_action_just_released("attack"):
		finished.emit(REELING, {"dir": player.facing_dir, "previous_state": previous_state})
