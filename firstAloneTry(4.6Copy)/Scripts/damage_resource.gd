extends Resource
class_name damage_profile

@export var amount: int = 10
@export var knockbackForce: float = 0.0
@export var knockbackDuration: float = 0.0
@export_flags("PLAYER", "ENEMY") var affects : int = global_defs.areAffected.ALL 
