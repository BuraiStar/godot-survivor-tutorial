extends Node2D
class_name SupportSkill

enum TriggerTime{
	ONREADY,
	PREFIRE,
	ONHIT,
	POSTHIT
}

var trigger_time : TriggerTime = TriggerTime.ONREADY;

func buff_effect(args: Array) :
	pass
	
func pre_fire_effect():
	pass
	
func on_hit_effect():
	pass
	
func post_hit_effect():
	pass
	
	
