class_name Food extends Area2D


@export var item: Global.CarryableItems
@export var item_type: Global.ItemType

var is_being_carried: bool = false


func change_pos(pos: Vector2):
	position = pos
