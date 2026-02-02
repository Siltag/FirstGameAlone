extends Node
class_name movement_comp

@export var body: CharacterBody2D
@export var speed := 100
@export var sprite : AnimatedSprite2D

var direction: Vector2
var player = GameState.player


func _physics_process(delta: float) -> void:
	
	player = GameState.player
	if player == null:
		return
		
	direction = (player.global_position - body.global_position).normalized()
	
	body.velocity = direction * speed
	
	if sprite != null:
		sprite.flip_h = direction.x < 0
	
	body.move_and_slide()
	
