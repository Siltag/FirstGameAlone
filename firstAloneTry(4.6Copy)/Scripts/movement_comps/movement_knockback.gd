extends Node
class_name MovementKnockback
@onready var m_base: movement_base = $"../movement_base"
@onready var body: CharacterBody2D = $"../.."

var knockback_velocity:= Vector2.ZERO


func apply_knockback(force: float, duration: float,target: CharacterBody2D, source_position: Vector2) :
	print("knockback applied")
	knockback_velocity = (target.global_position - source_position).normalized() * force
	
	m_base.override_velocity = knockback_velocity
	m_base.override_duration = duration


func _on_basic_enemy_hit(damage:damage_profile, source_location: Vector2) -> void:
	apply_knockback(damage.knockbackForce, damage.knockbackDuration, owner, source_location)
