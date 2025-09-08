class_name Player extends CharacterBody2D



@onready var ray_cast: RayCast2D = $ray_cast
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var carry_item_location: Node2D = $carry_item_location

@export var walk_speed := 50.0
@export var run_speed := 100.0

var animation_state: AnimationNodeStateMachinePlayback

var dir: Vector2 = Vector2.ZERO
var facing_dir: Vector2 = Vector2.DOWN

var state: String

var run: bool = false

var carry_item: Global.carry_items = Global.carry_items.NONE

enum tools { SWORD, AXE, BUCKET, PICKAXE, FISHINGROD }
var current_tool: tools = tools.SWORD

var object_on_way: String
var item_carrying: Global.carry_items = Global.carry_items.NONE


func _ready():
	animation_state = animation_tree["parameters/playback"]


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("run"):
		if run == false:
			run = true
		else:
			run = false
	
	if Input.is_action_just_pressed("inventory"):
		@warning_ignore("int_as_enum_without_cast")
		current_tool = (int(current_tool) + 1) % tools.size()
	
	ray_cast.target_position = facing_dir * 20
	
	if ray_cast.get_collider() != null:
		object_on_way = str(ray_cast.get_collider().name)
	else:
		object_on_way = ""
