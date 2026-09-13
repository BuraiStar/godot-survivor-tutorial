extends SupportSkill

var multiplierDamage = 1.3;
var multiplier_damage_per_level = 0.1;

func _ready() -> void:
	trigger_time = TriggerTime.ONREADY;
	max_level_of_support_gem = 5;

func buff_effect(args: Dictionary):
	args["damage_multiplier"] *= multiplierDamage + (multiplier_damage_per_level * (level_of_support_gem-1))
	return args;
