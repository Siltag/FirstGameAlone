extends CharacterBody2D
@onready var sword: AnimatableBody2D = $sword
@onready var movement_input: Node = $player_movement/movement_input
@onready var knockback: MovementKnockback = $player_movement/movement_knockback
@onready var sword_animation: AnimationPlayer = $Sword/blade/AnimationPlayer
@onready var damage_area: DamageArea = $Sword/blade/Sprite2D/DamageArea



@export var base_health := 100
@export var armor := 0
@export var move_speed := 200
@export var damage: damage_profile




#region damage and knockback
#var knockback: Vector2 = Vector2.ZERO
#var knockback_timer: float = 0.0
#func apply_knockback (direction: Vector2, force: float, knockback_duration: float) -> void:
	#knockback = direction*force
	#knockback_timer = knockback_duration

#func take_dmg(damage : damage_profile, source_position := Vector2.ZERO):

	#if(damage) != 0:
		#currentHP -= (damage.amount - armor)
		#var knockback_direction = (global_position - source_position).normalized()
		#apply_knockback(knockback_direction, damage.knockbackForce, damage.knockbackDuration)

#endregion


var flat_bonus_health := 0
var percentage_bonus_health := 1

var max_health: int = (base_health * percentage_bonus_health) + flat_bonus_health 

var _currentHP
var current_health:= 100 : 
	set(value):
		_currentHP = clamp(value, 0 ,max_health)
		
		print(_currentHP)
		
		if(_currentHP == 0):
			print("u shit")
			get_tree().reload_current_scene()
	get:
		return _currentHP



func take_damage(damage : damage_profile, target_position: Vector2):
	
	current_health -= (damage.amount - armor)
	
	knockback.apply_knockback(damage.knockbackForce, damage.knockbackDuration, self, target_position)




func _ready() -> void:
	
	GameState.player = self
	
	print("base health: ", base_health)
	
	current_health = (base_health * percentage_bonus_health) + flat_bonus_health


	movement_input.speed = move_speed
	damage_area.damage = damage
	

func _physics_process(delta: float) -> void:



	if Input.is_action_just_pressed("attack"):
		sword_animation.play("slash")


#region movement
	#if knockback_timer > 0.0:
		#velocity = knockback
		#knockback_timer -= delta
		#if knockback_timer <= 0.0:
			#knockback = Vector2.ZERO 

#endregion


	#move_and_slide()

func _exit_tree() -> void:
	if GameState.player == self:
		GameState.player = null
