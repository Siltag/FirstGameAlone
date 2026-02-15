extends Node
class_name HealthComp
@export var sprite : AnimatedSprite2D
@export var body : CharacterBody2D
@export var health_bar : TextureProgressBar
@export var dmg_area: DamageArea
@export var physical_body : CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"



@onready var label: Label = $Label
@onready var floating_number: Timer = $"floating number"


var base_health: float = 40 
var armor: int
var bonus_health_percantage : float = 1
var bonus_health_flat : int = 0


signal died
var _currentHP: float
var current_health: float = 100 : 
	set(value):
		_currentHP = clamp(value, 0.0 ,get_max_hp(base_health,bonus_health_percantage,bonus_health_flat))
		health_bar.value = _currentHP
		
		if _currentHP <= 0 :
			died.emit()
	get:
		return _currentHP

func get_max_hp(base: float, percentage: float = 1.0, flat: int = 0 ) -> float:
	return (base * percentage) + flat
	
func init(baseHP : float, _armor: int = 0, percantage: float = 1, flat: int = 0) -> void:
	base_health = baseHP
	armor = _armor
	bonus_health_flat = flat
	bonus_health_percantage = percantage
	current_health = get_max_hp(base_health,bonus_health_percantage,bonus_health_flat)
	health_bar.max_value = current_health
	health_bar.value = current_health


func _on_basic_enemy_hit(dmg: damage_profile, _source_location: Vector2) -> void:
	current_health -= dmg.amount
	label.visible = true
	label.text = str(dmg.amount)
	floating_number.start()
	
func _on_floating_number_timeout() -> void:
	label.visible = false
