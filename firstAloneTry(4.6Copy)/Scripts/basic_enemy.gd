extends CharacterBody2D

@export var health : float = 100
@export var speed : int = 100
@export var damage : damage_profile

@export var drop : PackedScene
@export var drop_tier : int

@onready var health_comp: HealthComp = $HealthComp
@onready var damage_area: DamageArea = $damageArea
@onready var m_base: movement_ai_basic = $Movement/Movement_ai_basic
@onready var m_knockback: MovementKnockback = $Movement/MovementKnockback
@onready var physical_body: CollisionShape2D = $CollisionShape2D


signal hit


func _ready() -> void:
	damage_area.damage = damage
	m_base.speed = speed
	health_comp.base_health = health
	health_comp.init(health)
	
	determine_spawn_location()


func take_damage(dmg: damage_profile, source_position: Vector2) -> void:
	hit.emit(dmg, source_position)


func determine_spawn_location() -> void:
	var player : CharacterBody2D = GameState.player
	var spawn_radius : int = 800
	var angle: float = randf() * TAU
	var spawn_location: Vector2 =  Vector2(cos(angle),sin(angle)) * spawn_radius
	

	global_position = player.global_position + spawn_location


func _on_timer_timeout() -> void:
	collision_layer = 4
	collision_mask = 4
