extends SupportSkill

var additional_fork_projectiles = 2.2;
var additional_fork_projectiles_per_level = .2;

func _ready() -> void:
	trigger_time = TriggerTime.ONREADY;
	max_level_of_support_gem = 10;

func buff_effect(args: Dictionary):
	args["fork_projectiles"] += floor(additional_fork_projectiles + (additional_fork_projectiles_per_level * (level_of_support_gem-1)))
	return args;
