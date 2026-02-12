extends Node
class_name movement_base

@export var body : CharacterBody2D

var desired_velocity := Vector2.ZERO
var override_velocity := Vector2.ZERO
var override_duration := 0.0

func _physics_process(delta: float) -> void:
	if override_duration > 0:
		body.velocity = override_velocity
		override_duration -= delta
	else:
		body.velocity = desired_velocity

	body.move_and_slide()
