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
var current_exp: int = 1;
var max_exp: int = 100;

func buff_effect(args: Dictionary) :
	pass
	
func pre_fire_effect():
	pass
	
func on_hit_effect():
	pass
	
func post_hit_effect():
	pass
	
func gemsGainEXP(exp_gained):
	if level_of_support_gem >= max_level_of_support_gem: 
		return
		
	current_exp += exp_gained;
	if current_exp >= max_exp && level_of_support_gem < max_level_of_support_gem:
		current_exp -= max_exp
		level_of_support_gem += max_level_of_support_gem;
	
	
