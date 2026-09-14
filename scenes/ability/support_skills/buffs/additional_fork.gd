extends SupportSkill

var additional_fork = 1.1;
var additional_fork_per_level = .1;

func _ready() -> void:
	trigger_time = TriggerTime.ONREADY;
	max_level_of_support_gem = 10;

func buff_effect(args: Dictionary):
	args["fork"] += floor(additional_fork + (additional_fork_per_level * (level_of_support_gem-1)))
	return args;
