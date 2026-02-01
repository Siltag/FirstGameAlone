extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword: AnimatableBody2D = $sword
@onready var slash_animation: AnimationPlayer = $"sword/slash animation"

#region stats
@export var maxHP: int 
@export var SPEED := 300.0
@export var armor := 0
#endregion


#region health
var _currentHP 
var mod_HP_percantage := 1
var mod_HP_flat := 0

var currentHP:
	set(value):
		_currentHP = clamp(value,0 , (maxHP*mod_HP_percantage)+mod_HP_flat)
		print(_currentHP)
		if _currentHP == 0:
			print("You died asshole")
			get_tree().reload_current_scene()

	get:
		return _currentHP
#endregion 

#region damage and knockback
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
func apply_knockback (direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction*force
	knockback_timer = knockback_duration

func take_dmg(damage : damage_profile, source_position := Vector2.ZERO):
	print(
	"affects =", damage.affects,
	" PLAYER bit =", global_defs.areAffected.PLAYER,
	" AND result =", damage.affects & global_defs.areAffected.PLAYER,
	
)
	if(damage.affects & global_defs.areAffected.PLAYER) != 0:
		currentHP -= (damage.amount - armor)
		var knockback_direction = (global_position - source_position).normalized()
		apply_knockback(knockback_direction, damage.knockbackForce, damage.knockbackDuration)

#endregion

#region movement function

#endregion


func _ready() -> void:
	_currentHP = maxHP
	

func _physics_process(delta: float) -> void:



	if Input.is_action_just_pressed("attack"):
		slash_animation.play("slash")


#region movement
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO 
	else:
		var move_input = Vector2(Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"),
			Input.get_action_strength("moveDown")-Input.get_action_strength("moveUp")).normalized()	
		if move_input != Vector2.ZERO:
			velocity = move_input * SPEED 
			
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)		
				


	if velocity.x >0:
		sprite.flip_h = true
	if velocity.x <0 :
		sprite.flip_h = false
	if velocity == Vector2.ZERO:
		sprite.play("idle")
	else:
		sprite.play("run")
#endregion


	move_and_slide()
