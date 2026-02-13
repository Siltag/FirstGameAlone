extends Node
class_name SpriteNode

@export var body : CharacterBody2D
@export var sprite : AnimatedSprite2D
@export var hurt_dr : float

var hurt_remain := 0.0

var alive := true

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if alive:
		if hurt_remain > 0:
			sprite.play("hurt")
			hurt_remain -= delta
		
		elif body.velocity != Vector2.ZERO:
			sprite.play("walk")
	
	#else:
		#sprite.play("idle")
	
	if body != GameState.player:
		sprite.flip_h = (body.velocity.x < 0.0)
	else:
		sprite.flip_h = (body.velocity.x > 0.0)
	
func _on_basic_enemy_hit(_dmg, _position):
	hurt_remain = hurt_dr


func _on_health_comp_died() -> void:
	alive = false
