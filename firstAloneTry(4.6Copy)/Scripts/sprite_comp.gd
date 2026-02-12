extends Node
class_name SpriteNode

@export var sprite : AnimatedSprite2D
@export var hurt_dr : float
@export var death_dr : float

var hurt_remain := 0.0 #duration
var death_remain := 0.0


func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if death_remain > 0:
		sprite.play("death")
		death_remain -= delta
		if death_remain <= 0:
			owner.queue_free()
		
	elif hurt_remain > 0:
		sprite.play("hurt")
		hurt_remain -= delta
	
	else:
		sprite.play("walk")

func _on_basic_enemy_hit(_dmg, _position):
	print("damn")
	hurt_remain = hurt_dr


func _on_health_comp_died() -> void:
	print(owner.name, " died")
	death_remain = death_dr
