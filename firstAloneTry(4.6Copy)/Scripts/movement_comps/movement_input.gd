extends Node
@onready var m_base: movement_base = $"../movement_base"
@onready var sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var m_dash: Node = $"../movement_dash_player"
@onready var player: CharacterBody2D = $"../.."

var speed :int
var velocity : Vector2 = Vector2.ZERO

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	
	
	var move_input = Vector2(Input.get_action_strength("moveRight")-Input.get_action_strength("moveLeft"), 
	Input.get_action_strength("moveDown")-Input.get_action_strength("moveUp")).normalized()
	
	if move_input != Vector2.ZERO:
		velocity = speed * move_input
		sprite.play("run")
	
	else:
		velocity = Vector2(move_toward(velocity.x, 0, speed), 
		move_toward(velocity.y, 0, speed))
		if (velocity == Vector2.ZERO):
			sprite.play("idle")
	
	if player.velocity.x > 0:
		animation_player.play("right")
	elif player.velocity.x < 0:
		animation_player.play("left")
	m_base.desired_velocity = velocity
	m_dash.normal_velocity = velocity
	
