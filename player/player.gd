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

var carry_item: Global.CarryableItems = Global.CarryableItems.NONE

enum tools { SWORD, AXE, BUCKET, PICKAXE, FISHINGROD }
var current_tool: tools = tools.SWORD

var object_on_way: Node

var item_carrying: Global.CarryableItems = Global.CarryableItems.NONE

var carry_object: Node

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
	
	object_on_way = ray_cast.get_collider()


func _physics_process(_delta: float) -> void:
	change_carry_pos(carry_object)


#Handle Pick and Drop
func change_carry_pos(item: Node):
	if item != null:
		if item.has_method("change_pos"):
			item.change_pos(carry_item_location.global_position)

func process_pick(item: Node):
	carry_object = item
	carry_object.is_being_carried = true
	var tween = item.create_tween()
	tween.tween_property(item, "position", carry_item_location.global_position, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func process_drop(item: Node = carry_object):
	item.is_being_carried = false
	var tween = item.create_tween()
	tween.tween_property(item, "position", global_position + ray_cast.target_position + Vector2(0, 10), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	carry_object = null
