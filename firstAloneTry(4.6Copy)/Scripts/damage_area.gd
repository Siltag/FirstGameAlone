extends Area2D
@export var damage: damage_profile

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_dmg"):
		body.take_dmg(damage, global_position)
		
