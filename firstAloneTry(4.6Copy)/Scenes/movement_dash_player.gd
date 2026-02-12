extends Node
class_name  movement_dash

#@export var sprite: AnimatedSprite2D
#@export var body: 
@onready var timer: Timer = $Timer

@export var m_base : movement_base
@export var dash_duration:= 0.15
@export var dash_multiplier := 5.0

@export var dash_cd := 2.0 :
	set(value):
		dash_cd = clamp(value, 0.0, 500)
		timer.wait_time = value



var normal_velocity : Vector2
var dash_velocity : Vector2
var can_dash := true



func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("dash") && can_dash:
		dash_velocity = normal_velocity * dash_multiplier
		m_base.override_velocity = dash_velocity
		m_base.override_duration = dash_duration
		can_dash = false
		timer.start()



func _on_timer_timeout() -> void:
	can_dash = true
