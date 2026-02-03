extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword: AnimatableBody2D = $sword
@onready var slash_animation: AnimationPlayer = $"sword/slash animation"


#
##region health
#var _currentHP 
#var mod_HP_percantage := 1
#var mod_HP_flat := 0

#var currentHP:
	#set(value):
		#_currentHP = clamp(value,0 , (maxHP*mod_HP_percantage)+mod_HP_flat)
		#print(_currentHP)
		#if _currentHP == 0:
			#print("You died asshole")
			#get_tree().reload_current_scene()
#
	#get:
		#return _currentHP
##endregion 

#region damage and knockback
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
func apply_knockback (direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction*force
	knockback_timer = knockback_duration

#func take_dmg(damage : damage_profile, source_position := Vector2.ZERO):

	#if(damage) != 0:
		#currentHP -= (damage.amount - armor)
		#var knockback_direction = (global_position - source_position).normalized()
		#apply_knockback(knockback_direction, damage.knockbackForce, damage.knockbackDuration)

#endregion

#region movement function

#endregion


func _ready() -> void:
	GameState.player = self

func _physics_process(delta: float) -> void:



	if Input.is_action_just_pressed("attack"):
		slash_animation.play("slash")


#region movement
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO 

#endregion


	move_and_slide()

func _exit_tree() -> void:
	if GameState.player == self:
		GameState.player = null
