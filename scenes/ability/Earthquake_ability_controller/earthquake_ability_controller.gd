extends ActiveSkillAbility

func _init() -> void:
	skill_stats = {
		"damage": 7.5,
		"damage_multiplier": 1.0,
		"cooldown": 1.0,
		"range_multiplier": 1.0,
		"area_multiplier": 1.0,
		"MAX_RANGE": 100,
	}
	pass;

func _ready():
	_buff_effects();
	$Timer.wait_time = $Timer.wait_time * skill_stats["cooldown"]
	$Timer.timeout.connect(on_timer_timeout)
	print(skill_stats["cooldown"]);
	print($Timer.wait_time);
	$Timer.start()


func on_timer_timeout(): 
	var player = get_tree().get_first_node_in_group("player") as Node2D 
	if player == null: 
		return 
	
	var mouse_position := get_global_mouse_position() 
	var player_position = player.global_position 
	var direction = mouse_position - player_position 
	if direction.length() > skill_stats["MAX_RANGE"] * skill_stats["range_multiplier"]: 
		direction = direction.normalized() * skill_stats["MAX_RANGE"] * skill_stats["range_multiplier"]
	
	var earthquake_position = player_position + direction 
	var earthquake_instance = ability.instantiate() as EarthQuakeAbility 
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") 
	if foreground_layer == null: 
		foreground_layer = get_tree().current_scene 
		
	foreground_layer.add_child(earthquake_instance) 
	earthquake_instance.hitbox_component.damage = skill_stats["damage"] * skill_stats["damage_multiplier"] 
	earthquake_instance.global_position = earthquake_position
	earthquake_instance.scale.x = skill_stats["area_multiplier"]
	earthquake_instance.scale.y = skill_stats["area_multiplier"]
	
	
func _buff_effects():
	for child in $Modifiers.get_children():
		if child is SupportSkill and child.trigger_time == SupportSkill.TriggerTime.ONREADY:
			skill_stats = child.buff_effect(skill_stats)
