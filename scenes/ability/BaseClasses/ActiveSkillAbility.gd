extends Node2D
class_name ActiveSkillAbility

var skill_stats := {
	"damage": 7.5,
	"damage_multiplier": 1.0,
	"cooldown": 1.0,
	"range_multiplier": 1.0,
	"area_multiplier": 1.0,
	"MAX_RANGE": 100,
}

@export var ability: PackedScene
var base_wait_time

func _buff_effects():
	pass

func _pre_fire_effects():
	pass
		
func _on_hit_effects():
	pass;
	
func _post_hit_effects():
	pass;
