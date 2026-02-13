extends Area2D
class_name Orb

@onready var tier_1: AnimatedSprite2D = $Sprites/TIER1
@onready var tier_2: AnimatedSprite2D = $Sprites/TIER2
@onready var tier_3: AnimatedSprite2D = $Sprites/TIER3

var tier := 3
var base_exp := 1.0


var exp_amount: float
var animation 

func init(_tier: int):
	tier = _tier
	exp_amount = base_exp * tier * tier * randf()
	match _tier:
		1:
			tier_1.visible = true
		2:
			tier_2.visible = true
		3:
			tier_3.visible = true
