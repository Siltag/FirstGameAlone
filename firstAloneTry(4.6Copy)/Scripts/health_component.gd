extends Node
class_name HealthComp


var base_health: int 
var armor: int

var flat_bonus_health := 0
var percentage_bonus_health := 1

var max_health: int = (base_health * percentage_bonus_health) + flat_bonus_health 

var _currentHP
var current_health:= 100 : 
	set(value):
		_currentHP = clamp(value, 0 ,max_health)
		
		print(_currentHP)
	get:
		return _currentHP

func _ready() -> void:
	current_health = (base_health * percentage_bonus_health) + flat_bonus_health
	

func take_damage(damage : damage_profile, target_position: Vector2):
	current_health -= (damage.amount - armor)
