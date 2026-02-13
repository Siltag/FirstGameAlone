extends Node

@export var enemy : PackedScene
@export var enemy_spawn_cooldown : float

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = enemy_spawn_cooldown

func _on_timer_timeout() -> void:
	enemy_spawner()
	
func enemy_spawner():
	var  enem = enemy.instantiate()
	add_sibling(enem)
