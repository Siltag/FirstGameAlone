extends Area2D
class_name Orb

@onready var tier_1: AnimatedSprite2D = $Sprites/TIER1
@onready var tier_2: AnimatedSprite2D = $Sprites/TIER2
@onready var tier_3: AnimatedSprite2D = $Sprites/TIER3

var tier : int = 3
var base_exp : float = 10.0


var exp_amount: float

func init(_tier: int) -> void:
	tier = _tier
	exp_amount = snapped(base_exp * tier * tier * randf(), 0.1)
	match _tier:
		1:
			tier_1.visible = true
			tier_1.play("tier1")
		2:
			tier_2.visible = true
			tier_2.play("tier1")
		3:
			tier_3.visible = true
			tier_3.play("tier1")

func _on_body_entered(body: Node2D) -> void:
	body.collect_orb(exp_amount)
	queue_free()
