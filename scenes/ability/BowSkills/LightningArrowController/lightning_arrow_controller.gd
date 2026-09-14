extends ActiveSkillAbility

var forkAmount = null;
const BOW_SHOT_SOUND = preload("res://assets/audio/SoundEffect/BowReleaseArrow.mp3")

func _init() -> void:
	skill_stats = {
		"damage": 4,
		"damage_multiplier": 1.0,
		"cooldown": 1.0,
		"range_multiplier": 1.0,
		"area_multiplier": 1.0,
		"additional_projectiles": 1,
		"increase_effect": 1,
		"MAX_RANGE": 100,
		"fork":0,
		"fork_projectiles": 2
	}
	pass;

func _ready():
	_buff_effects();
	
	$Timer.wait_time = $Timer.wait_time * skill_stats["cooldown"]
	$Timer.timeout.connect(on_timer_timeout)
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
	_play_audio();
	_spawn_lightning_arrow(player_position, direction.normalized(), 1);
	
	
func _buff_effects():
	for child in $Modifiers.get_children():
		if child is SupportSkill and child.trigger_time == SupportSkill.TriggerTime.ONREADY:
			skill_stats = child.buff_effect(skill_stats)

		
func _spawn_lightning_arrow(position: Vector2, direction:Vector2 , generation: int):
	var lightning_arrow_instance = ability.instantiate() as LightningArrowAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if foreground_layer == null:
		foreground_layer = get_tree().current_scene

	foreground_layer.add_child(lightning_arrow_instance)

	lightning_arrow_instance.hitbox_component.damage = (
		(skill_stats["damage"]/ generation) *
		skill_stats["damage_multiplier"]
	)
	lightning_arrow_instance.global_position = position
	
	var area = skill_stats["area_multiplier"]
	lightning_arrow_instance.arrowModifiers["scale"] = Vector2(area, area);
	lightning_arrow_instance.arrowModifiers["direction"] = direction;
	
	

func _play_audio():
	if $AudioStreamPlayer2D:
		$AudioStreamPlayer2D.play()
		
