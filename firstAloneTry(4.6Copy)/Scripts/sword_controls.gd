extends Node2D
@export var sword_animation : AnimationPlayer
@export var sprite : AnimatedSprite2D


@onready var spin_timer: Timer = $spin_cooldown
var can_spin := true

var _cooldown:= 1.0
var cooldown := 1.0 :
	set (value):
		_cooldown = value
		spin_timer.wait_time = spin_timer.wait_time * _cooldown
	get:
		return _cooldown
 
var _attack_speed
var attack_speed: float :
	set(value):
		_attack_speed = value
		if sword_animation:
			sword_animation.speed_scale = value
	get:
		return _attack_speed
		
func _ready() -> void:
	spin_timer.wait_time *= cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		if sprite.flip_h:
			sword_animation.play("swing_right")
		else:
			sword_animation.play("swing_left")
	
	if Input.is_action_just_pressed("spin") && can_spin:
		if sprite.flip_h:
			sword_animation.play("swing_spin_right")
		else:
			sword_animation.play("swing_spin_left")
		can_spin = false
		spin_timer.start()


func _on_spin_cooldown_timeout() -> void:
	can_spin = true
