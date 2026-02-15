extends CharacterBody2D
@onready var movement_input: Node = $player_movement/movement_input
@onready var knockback: MovementKnockback = $player_movement/movement_knockback
@onready var damage_area: DamageArea = $Sword/blade/Sprite2D/DamageArea
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_animation: AnimationPlayer = $Sword/blade/Sprite2D/AnimationPlayer
@onready var sword: Node2D = $Sword/blade
@onready var physical_body: CollisionShape2D = $CollisionShape2D
@onready var iFrames: Timer = $immunity_frames
@export var blood: AnimatedSprite2D


@export var base_health : int = 100
@export var armor : int = 0
@export var move_speed : int = 200
@export var attack_speed : float = 1.0 
@export var cooldown: float = 1.0


@export var damage: damage_profile


#region Health
var flat_bonus_health : int = 0
var percentage_bonus_health : float = 1

var max_health: float = (base_health * percentage_bonus_health) + flat_bonus_health 
#
# GET MAX HP FUNCTION NEEDED
#
var _currentHP : float
var current_health: float = 100 : 
	set(value):
		_currentHP = clamp(value, 0 ,max_health)
		
		print(_currentHP)
		
		if(_currentHP == 0):
			print("u shit")
			get_tree().reload_current_scene()
	get:
		return _currentHP

func take_damage(dmg : damage_profile, target_position: Vector2) -> void:
	current_health -= (dmg.amount - armor)
	knockback.apply_knockback(dmg.knockbackForce, dmg.knockbackDuration, self, move_speed, target_position)
	collision_layer = 256
	iFrames.start()
	blood.play("default")
	
	
#endregion

#region exp

var _exp : float= 0.0
var expi : float = 0.0 :
	set(value):
		_exp = value
		print("Your exp: ",_exp)
	get:
		return _exp

func collect_orb(_exp_amount : float) -> void:
	expi += _exp_amount
	expi += 10

#endregion


func _ready() -> void:

	GameState.player = self
	current_health = (base_health * percentage_bonus_health) + flat_bonus_health
	movement_input.speed = move_speed
	damage_area.damage = damage
	sword_animation.speed_scale = attack_speed
	sword.attack_speed = attack_speed
	sword.cooldown = cooldown
	sword.damage = damage

#func _physics_process(_delta: float) -> void:
	#if Input.is_action_just_pressed("debug"):
		#percentage_bonus_health += 0.1

func _exit_tree() -> void:
	if GameState.player == self:
		GameState.player = null


func _on_immunity_frames_timeout() -> void:
	collision_layer = 2
