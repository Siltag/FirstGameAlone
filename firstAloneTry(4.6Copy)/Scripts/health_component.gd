extends Node2D
class_name healthComponent

@export var maxHP := 100

var _currentHP
var currentHP: 
	set(value):
		_currentHP = clamp(value, 0, maxHP)
		print(_currentHP)

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
