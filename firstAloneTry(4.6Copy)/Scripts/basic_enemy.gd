extends CharacterBody2D

@export var health := 100
@export var speed := 100
@export var damage : damage_profile

@onready var health_comp: HealthComp = $HealthComp
@onready var damage_area: DamageArea = $damageArea
@onready var movement: movement_ai_basic = $Movement/Movement_ai_basic

signal hit


func _ready() -> void:
	damage_area.damage = damage
	movement.speed = speed
	health_comp.health = health
	
func take_damage(dmg: damage_profile, source_position: Vector2):
	hit.emit(dmg, source_position)
	print("enemy hit")
