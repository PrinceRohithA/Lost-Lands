class_name PlayerState extends State

const IDLE = "idle"
const WALK = "walk"
const RUN = "run"
const ATTACK = "attack"
const AXE = "axe"
const PICKAXE = "pickaxe"
const FISHING = "fishing"
const WATERING = "watering"
const REELING = "reeling"
const PICKING = "picking"
const CARRY_IDLE = "carry_idle"
const CARRY_WALK = "carry_walk"
const CARRY_RUN = "carry_run"
const DROPPING = "dropping"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
