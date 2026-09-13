extends SupportSkill

var triggerType = TriggerTime.ONREADY
var additionalSize = 1.3;

func buff_effect(args: Array):
	args[0] *= additionalSize
	return args;
