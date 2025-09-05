class_name Player extends CharacterBody2D


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var walk_speed := 50.0
@export var run_speed := 100.0

var animation_state: AnimationNodeStateMachinePlayback

var dir: Vector2 = Vector2.ZERO
var facing_dir: Vector2 = Vector2.DOWN

var state: String

var run: bool = false

func _ready():
	animation_state = animation_tree["parameters/playback"]
