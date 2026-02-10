extends Node
class_name HealthComp
@export var sprite : AnimatedSprite2D
@export var body : CharacterBody2D
@export var health_bar : TextureProgressBar
@onready var death: Timer = $death

var base_health:= 40 
var armor: int
var bonus_health_percantage := 1
var bonus_health_flat := 0


var _currentHP: int
var current_health:= 100 : 
	set(value):
		_currentHP = clamp(value, 0 ,get_max_hp(base_health,bonus_health_percantage,bonus_health_flat))
		print(_currentHP)
		health_bar.value = _currentHP

		
		if _currentHP <= 0 :
			print(body.name, " died")
			death.start()
			sprite.play("death")
		
	get:
		return _currentHP

func get_max_hp(base: int, percentage:= 1.0, flat:= 0 ) -> float:
	return (base * percentage) + flat
	
func init(baseHP, _armor:= 0, percantage:= 1, flat:= 0):
	base_health = baseHP
	armor = _armor
	bonus_health_flat = flat
	bonus_health_percantage = percantage
	current_health = get_max_hp(base_health,bonus_health_percantage,bonus_health_flat)
	health_bar.max_value = current_health
	health_bar.value = current_health


func take_damage(damage : damage_profile, target_position: Vector2):
	current_health -= (damage.amount - armor)
	

func _on_basic_enemy_hit(dmg: damage_profile, source_location: Vector2) -> void:
	take_damage(dmg, source_location)


func _on_death_timeout() -> void:
	body.queue_free()
