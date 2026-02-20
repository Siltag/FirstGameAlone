extends CharacterBody2D
@onready var movement_input: Node = $player_movement/movement_input
@onready var knockback: MovementKnockback = $player_movement/movement_knockback
@onready var damage_area: DamageArea = $Sword/blade/Sprite2D/DamageArea
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_animation: AnimationPlayer = $Sword/blade/Sprite2D/AnimationPlayer
@onready var sword: Node2D = $Sword/blade
@onready var physical_body: CollisionShape2D = $CollisionShape2D
@onready var iFrames: Timer = $immunity_frames
@onready var blood: AnimatedSprite2D = $blood



@export var base_health : int = 100
@export var armor : int = 0
@export var move_speed : int = 200
@export var attack_speed : float = 1.0 
@export var cooldown: float = 1.0

@export var damage: damage_profile


#region Health
var max_health: float = base_health
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
	if (dmg.amount > armor):
		current_health -= (dmg.amount - armor)
	knockback.apply_knockback(dmg.knockbackForce, dmg.knockbackDuration, self, move_speed, target_position)
	collision_layer = 256
	iFrames.start()
	blood.play("default")

#endregion

#region Stat Adjust Functions

func adjust_stat(stat: String, bonus:float) -> void:
	match stat:
		"hp":
			var current_percentage: float = current_health/max_health
			max_health *= (bonus+100)/100
			current_health = max_health * current_percentage
		"armor":
			@warning_ignore("narrowing_conversion")
			armor += bonus
		"ms":
			movement_input.speed *= (bonus+100)/100
		"as":
			sword.attack_speed *= (bonus+100)/100
		"cd":
			sword.cooldown *= (100-bonus)/100
		"dmg":
			sword.damage.amount *= (bonus+100)/100
		"knockback":
			sword.damage.knockbackForce *= (bonus+100)/100
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
	current_health = max_health
	movement_input.speed = move_speed
	damage_area.damage = damage
	sword_animation.speed_scale = attack_speed
	sword.attack_speed = attack_speed
	sword.cooldown = cooldown
	sword.damage = damage

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		adjust_stat("knocback", 5000)




func _on_immunity_frames_timeout() -> void:
	collision_layer = 2

func _exit_tree() -> void:
	if GameState.player == self:
		GameState.player = null
