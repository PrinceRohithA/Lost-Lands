extends Node


@onready var player: Player = $environment/player

@onready var x_label_dir: Label = $CanvasLayer/Control/VBoxContainer/x_label
@onready var y_label_dir: Label = $CanvasLayer/Control/VBoxContainer/y_label
@onready var x_label_face: Label = $CanvasLayer/Control/VBoxContainer/x_label2
@onready var y_label_face: Label = $CanvasLayer/Control/VBoxContainer/y_label2
@onready var state_label: Label = $CanvasLayer/Control/state_label
@onready var run_label: Label = $CanvasLayer/Control/VBoxContainer2/run_label
@onready var tool_label: Label = $CanvasLayer/Control/VBoxContainer2/tool_label
@onready var object_label: Label = $CanvasLayer/Control/VBoxContainer2/object_label


func _process(_delta: float) -> void:
	x_label_dir.text = "x :  " + str(roundf(player.dir.x))
	y_label_dir.text = "y :  " + str(roundf(player.dir.y))
	x_label_face.text = "x :  " + str(roundf(player.facing_dir.x))
	y_label_face.text = "y :  " + str(roundf(player.facing_dir.y))
	state_label.text = "State :  " + clean_name(Global.current_state).capitalize()
	run_label.text = "Run :  " + str(player.run).capitalize()
	tool_label.text = "Tool :  " + get_tool_name(player.current_tool)
	object_label.text = "Object :  " + player.object_on_way


func clean_name(_name: String) -> String:
	if ":" in _name:
		return _name.split(":")[0].strip_edges()
	return _name

func get_tool_name(current_tool) -> String:
	if current_tool == player.tools.SWORD:
		return "Sword"
	elif current_tool == player.tools.AXE:
		return "Axe"
	elif current_tool == player.tools.BUCKET:
		return "Bucket"
	elif current_tool == player.tools.PICKAXE:
		return "Pickaxe"
	elif current_tool == player.tools.FISHINGROD:
		return "Fishing Rod"
	return str(current_tool)
