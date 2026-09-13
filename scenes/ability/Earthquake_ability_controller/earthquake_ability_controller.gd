extends Node2D
class_name SkillAbility

var MAX_RANGE = 100

@export var ability: PackedScene

var base_damage = 7.5
var additional_damage_percent: float = 1.0
var base_wait_time

func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	pass
