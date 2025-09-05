extends Node


@onready var player: Player = $environment/player

@onready var x_label_dir: Label = $CanvasLayer/Control/VBoxContainer/x_label
@onready var y_label_dir: Label = $CanvasLayer/Control/VBoxContainer/y_label
@onready var x_label_face: Label = $CanvasLayer/Control/VBoxContainer/x_label2
@onready var y_label_face: Label = $CanvasLayer/Control/VBoxContainer/y_label2
@onready var state_label: Label = $CanvasLayer/Control/state_label
@onready var run_label: Label = $CanvasLayer/Control/run_label


func _process(_delta: float) -> void:
	x_label_dir.text = "x :  " + str(roundf(player.dir.x))
	y_label_dir.text = "y :  " + str(roundf(player.dir.y))
	x_label_face.text = "x :  " + str(roundf(player.facing_dir.x))
	y_label_face.text = "y :  " + str(roundf(player.facing_dir.y))
	state_label.text = "State :  " + clean_name(Global.current_state).capitalize()
	run_label.text = "Run :  " + str(player.run) 


func clean_name(name: String) -> String:
	if ":" in name:
		return name.split(":")[0].strip_edges()
	return name
