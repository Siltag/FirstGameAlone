extends Node
class_name HealthComp

@export var base_health := 100
@export var armor := 0

var flat_bonus_health := 0
var percentage_bonus_health := 1

var max_health: int = (base_health * percentage_bonus_health) + flat_bonus_health

var _currentHP
var current_health: int :
	set(value):
		_currentHP = clamp(value, 0 ,max_health)
		print(_currentHP)
		if _currentHP == 0:
			print("you shit")
			get_tree().reload_current_scene()
	get:
		return _currentHP

func _ready() -> void:
	current_health = max_health

func _on_damage_hit(damage:damage_profile):
	current_health -= (damage.amount - armor)
