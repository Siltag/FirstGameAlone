extends Node
class_name HealthComp


var health: int 
var armor: int

var _currentHP
var current_health:= 100 : 
	set(value):
		_currentHP = clamp(value, 0 ,health)
		print(_currentHP)
		
	get:
		return _currentHP

func _ready() -> void:
	current_health = health

func take_damage(damage : damage_profile, target_position: Vector2):
	current_health -= (damage.amount - armor)
	print("enemy hit 2")


func _on_basic_enemy_hit(dmg: damage_profile, source_location: Vector2) -> void:
	take_damage(dmg, source_location)
