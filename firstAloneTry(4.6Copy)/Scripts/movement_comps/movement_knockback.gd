extends Node
class_name MovementKnockback
@onready var m_base: movement_base = $"../movement_base"

var knockback_velocity:= Vector2.ZERO

func apply_knockback(force: float, duration: float,target: CharacterBody2D, source_position: Vector2) :
	print("knockback applied")
	knockback_velocity = (target.global_position - source_position).normalized() * force
	
	m_base.override_velocity = knockback_velocity
	m_base.override_duration = duration
