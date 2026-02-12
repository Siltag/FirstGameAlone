extends Area2D
class_name Orb

@export var tier := 1
var exp_amount
var animation

match tier:
	1:
		exp_amount = 10
