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
	
	determine_spawn_location()


func take_damage(dmg: damage_profile, source_position: Vector2):
	hit.emit(dmg, source_position)


func determine_spawn_location():
	var viewport_size = get_viewport_rect().size
	var spawn_direction = ["top","bottom","left","right"].pick_random()
	
	match spawn_direction:
		"top":
			global_position.y-=viewport_size.y
			global_position.x+= randf_range(-viewport_size.x,viewport_size.x)
		"bottom":
			global_position.y+=viewport_size.y
			global_position.x+= randf_range(-viewport_size.x,viewport_size.x)
		"left":
			global_position.x-=viewport_size.x
			global_position.y+= randf_range(-viewport_size.y,viewport_size.y)
		"right":
			global_position.x+=viewport_size.x
			global_position.y+= randf_range(-viewport_size.y,viewport_size.y)
