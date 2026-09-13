extends Node2D
class_name SupportSkill

enum TriggerTime{
	ONREADY = 0,
	PREFIRE = 1,
	ONHIT = 2,
	POSTHIT = 3
}

var trigger_time : TriggerTime = TriggerTime.ONREADY;

var level_of_support_gem: int = 1;
var max_level_of_support_gem: int = 1;

func buff_effect(args: Dictionary) :
	pass
	
func pre_fire_effect():
	pass
	
func on_hit_effect():
	pass
	
func post_hit_effect():
	pass
	
	
