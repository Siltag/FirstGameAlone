extends Node
class_name movement_ai_basic

@export var body: CharacterBody2D

var player
var direction : Vector2
var speed
var desired_velocity

@onready var movement_base: movement_base = $"../movement_base"

func _ready() -> void:
	player = GameState.player
	
func _physics_process(delta: float) -> void:
	direction = (player.global_position - body.global_position).normalized()
	movement_base.desired_velocity = direction * speed
