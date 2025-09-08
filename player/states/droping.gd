extends PlayerState



func enter(_previous_state: String, data: Dictionary = {}) -> void:
	if data.has("dir") and data["dir"] != Vector2.ZERO:
		player.facing_dir = data["dir"]
	
	if data.has("carry_item"):
		player.carry_item = data["carry_item"]
	
	player.animation_tree["parameters/dropping/blend_position"] = player.facing_dir * Vector2(1, -1)
	player.animation_state.travel("dropping")


func update(_delta: float) -> void:
	if !player.animation_state.get_current_node() == "dropping":
		finished.emit(IDLE, {"dir": player.facing_dir, "carry_item": player.carry_item})
