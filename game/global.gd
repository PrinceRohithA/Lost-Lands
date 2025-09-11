extends Node


const FOOD_SCENE_LOCATION = "res://items/food/food.tscn"

enum CarryableItems { NONE, RAW_CHICKEN, COOKED_CHICKEN }
enum FoodItems { NONE, RAW_CHICKEN, COOKED_CHICKEN }

enum ItemType { NONE, FOOD }

var current_state: String
