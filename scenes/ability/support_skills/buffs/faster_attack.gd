extends SupportSkill

var faster_attack = 0.9;
var faster_attack_per_level = 0.01;

func _ready() -> void:
	trigger_time = TriggerTime.ONREADY;
	max_level_of_support_gem = 5;

func buff_effect(args: Dictionary):
	args["cooldown"] *= faster_attack - (faster_attack_per_level * (level_of_support_gem-1))
	return args;
