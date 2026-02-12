extends CharacterBody2D

@export var health := 100
@export var speed := 100
@export var damage : damage_profile

@onready var health_comp: HealthComp = $HealthComp
@onready var damage_area: DamageArea = $damageArea
@onready var m_base: movement_ai_basic = $Movement/Movement_ai_basic
@onready var m_knockback: MovementKnockback = $Movement/MovementKnockback


signal hit


func _ready() -> void:
	damage_area.damage = damage
	m_base.speed = speed
	health_comp.base_health = health
	health_comp.init(health)
	

func take_damage(dmg: damage_profile, source_position: Vector2):
	hit.emit(dmg, source_position)
