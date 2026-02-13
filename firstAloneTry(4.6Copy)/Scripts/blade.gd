extends Node2D

@export var damage: damage_profile
@export var sword_animation : AnimationPlayer
@export var owner_sprite : AnimatedSprite2D
@export var spin_timer : Timer

#@onready var spin_timer: Timer = $spin_cooldown


#region stat setters
var can_spin := true
var base_cooldown := 5
var _cooldown:= 1.0
var cooldown := 1.0 :
	set (value):
		_cooldown = value
		if spin_timer:
			spin_timer.wait_time = base_cooldown * _cooldown
	get:
		return _cooldown
 
#var base_attack_speed := 1
var _attack_speed
var attack_speed: float :
	set(value):
		_attack_speed = value
		if sword_animation:
			sword_animation.speed_scale = value
	get:
		return _attack_speed
#endregion



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spin_timer.wait_time = base_cooldown * cooldown

var init_dmg : damage_profile
var init_as : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		if owner_sprite.flip_h:
			sword_animation.play("swing_right")
		else:
			sword_animation.play("swing_left")
	
	if Input.is_action_just_pressed("spin") && can_spin:
		init_dmg = damage.duplicate()
		init_as = attack_speed
		damage.amount *= 3
		damage.knockbackForce *= 3
		attack_speed *= 2
		if owner_sprite.flip_h:
			sword_animation.play("skill_spin_right")
		else:
			sword_animation.play("skill_spin_left")
			
		can_spin = false
		spin_timer.start()


func _on_spin_cooldown_timeout() -> void:
	can_spin = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("skill"):
		damage.amount = init_dmg.amount
		damage.knockbackForce = init_dmg.knockbackForce
		attack_speed = init_as
