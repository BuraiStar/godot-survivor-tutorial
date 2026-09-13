extends SupportSkill

var additional_damage = 3;
var additional_damage_per_level = 2;

func _ready() -> void:
	trigger_time = TriggerTime.ONREADY;
	max_level_of_support_gem = 5;

func buff_effect(args: Dictionary):
	args["damage"] += additional_damage + (additional_damage_per_level * (level_of_support_gem-1))
	return args;
