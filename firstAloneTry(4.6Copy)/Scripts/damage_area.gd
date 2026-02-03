extends Area2D
class_name DamageArea
@export var damage: damage_profile

signal damage_hit(damage: damage_profile, source_postion : Vector2)



func _on_body_entered(body: Node2D) -> void:
	emit_signal("damage_hit", damage, global_position)
