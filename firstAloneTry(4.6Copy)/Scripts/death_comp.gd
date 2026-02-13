extends Node
class_name DeathComp

@export var sprite : AnimatedSprite2D
@export var drop : PackedScene
@export var drop_tier := 1
@export var physical_body : CollisionShape2D
@export var health_bar : TextureProgressBar
@export var dmg_area : DamageArea

@onready var timer: Timer = $Timer


var alive := true
var death_dur := 2.0
var death_started := false



func _on_health_comp_died():
	sprite.play("death")

	health_bar.queue_free()
	dmg_area.queue_free()
	owner.collision_layer = 0
	owner.collision_mask = 0

	var death_pos = owner.global_position
	call_deferred("_spawn_orb", death_pos)
	timer.start()





func _spawn_orb(pos: Vector2):
	var orb: Node2D = drop.instantiate()
	owner.get_parent().add_child(orb)
	orb.global_position = pos
	orb.init(1)

func _on_timer_timeout() -> void:
	owner.queue_free()
