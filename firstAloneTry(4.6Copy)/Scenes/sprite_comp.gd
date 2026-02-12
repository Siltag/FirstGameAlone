extends Node
class_name SpriteNode

@export var sprite : AnimatedSprite2D


var hurt_dr := 0.0 #duration
var death_dr := 0.0


func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if death_dr > 0:
		sprite.play("death")
		death_dr -= delta
	elif hurt_dr > 0:
		sprite.play("hurt")
		hurt_dr -= delta
		#print(hurt_dr)
	
	else:
		sprite.play("walk")
		#print(hurt_dr)
	pass

func _on_basic_enemy_hit(_dmg, _position):
	print("damn")
	hurt_dr = 1000
	print(hurt_dr)
