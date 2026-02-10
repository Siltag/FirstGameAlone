extends CharacterBody2D

@export var health := 100
@export var speed := 100
@export var damage : damage_profile

@onready var damage_area: DamageArea = $damageArea
@onready var movement: movement_ai_basic = $Movement_ai_basic




func _ready() -> void:
	damage_area.damage = damage
	movement.speed = speed
