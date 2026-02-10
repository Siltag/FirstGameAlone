extends Node

@export var speed := 300
@export var body : CharacterBody2D
@export var sprite: AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if body.velocity.x >0:
		sprite.flip_h = true
	if body.velocity.x <0 :
		sprite.flip_h = false
	if body.velocity == Vector2.ZERO:
		sprite.play("idle")
	else:
		sprite.play("run")
	pass

func _physics_process(delta: float) -> void:
	
	
	var move_input = Vector2(Input.get_action_strength("moveRight")-Input.get_action_strength("moveLeft"), 
	Input.get_action_strength("moveDown")-Input.get_action_strength("moveUp")).normalized()
	
	if move_input != Vector2.ZERO:
		body.velocity = move_input * speed
	else:
		body.velocity = Vector2(move_toward(body.velocity.x, 0, speed), 
		move_toward(body.velocity.y, 0, speed))
	
	body.move_and_slide()
	
	
