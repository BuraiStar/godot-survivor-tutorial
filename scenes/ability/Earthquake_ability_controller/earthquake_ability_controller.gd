extends ActiveSkillAbility

var forkAmount = null;
const EARTHQUAKE_SOUND = preload("res://assets/audio/SoundEffect/Explosion.mp3")

func _init() -> void:
	skill_stats = {
		"damage": 7.5,
		"damage_multiplier": 1.0,
		"cooldown": 1.0,
		"range_multiplier": 1.0,
		"area_multiplier": 1.0,
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
	var played_generations := {}
	if player == null: 
		return 
	
	var mouse_position := get_global_mouse_position() 
	var player_position = player.global_position 
	var direction = mouse_position - player_position 
	if direction.length() > skill_stats["MAX_RANGE"] * skill_stats["range_multiplier"]: 
		direction = direction.normalized() * skill_stats["MAX_RANGE"] * skill_stats["range_multiplier"]
	_play_explosion_audio(played_generations, 1, player_position);
	
	var earthquake_position = player_position + direction 
	_spawn_earthquake(earthquake_position, 1);
	_fork_effect(earthquake_position, direction.normalized(), skill_stats["fork"], 1, played_generations)
	
	
func _buff_effects():
	for child in $Modifiers.get_children():
		if child is SupportSkill and child.trigger_time == SupportSkill.TriggerTime.ONREADY:
			skill_stats = child.buff_effect(skill_stats)

func _fork_effect(
	current_position: Vector2,
	direction: Vector2,
	forks_remaining: int,
	generation: int,
	played_generations: Dictionary
):
	if forks_remaining <= 0:
		return
	
	await get_tree().create_timer(0.3).timeout
	var projectile_count: int = skill_stats["fork_projectiles"]
	var max_angle: float = 45.0
	var base_fork_distance: float = 50.0
	var distance_falloff := 10.0
	var fork_distance = max(
		base_fork_distance - ((generation - 2) * distance_falloff),
		20.0
	)
	generation += 1;
	
	var angles := _get_fork_angles(projectile_count, max_angle)
	_play_explosion_audio(played_generations, generation, current_position);
	for angle in angles:
		var fork_direction := direction.rotated(deg_to_rad(angle))
		var fork_position = current_position + fork_direction * fork_distance

		_spawn_earthquake(fork_position, generation)

		_fork_effect(
			fork_position,
			fork_direction,
			forks_remaining - 1,
			generation, 
			played_generations
		)
		
func _spawn_earthquake(position: Vector2, generation: int):
	var earthquake_instance = ability.instantiate() as EarthQuakeAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if foreground_layer == null:
		foreground_layer = get_tree().current_scene

	foreground_layer.add_child(earthquake_instance)

	earthquake_instance.hitbox_component.damage = (
		(skill_stats["damage"]/ generation) *
		skill_stats["damage_multiplier"]
	)
	earthquake_instance.global_position = position
	
	var area = skill_stats["area_multiplier"] * max(1 - ((generation - 1) * .15), .4)
	earthquake_instance.scale = Vector2(area, area);
	
	
func _get_fork_angles(projectile_count: int, max_angle: float) -> Array:
	var angles: Array = []

	if projectile_count <= 0:
		return angles

	if projectile_count == 1:
		angles.append(0.0)
		return angles

	var angle_step = (max_angle * 2.0) / (projectile_count - 1)

	for i in range(projectile_count):
		var angle = max_angle - (angle_step * i)
		angles.append(angle)

	return angles

func _play_explosion_audio(played_generations: Dictionary, generation: int, position: Vector2):
	if played_generations.has(generation):
		return
	played_generations[generation] = true;
	if AudioManager:
		AudioManager.play_2d(
			EARTHQUAKE_SOUND,
			max(20 - (2 * generation), 10)
		)
	elif $AudioStreamPlayer2D:
		$AudioStreamPlayer2D.play()
		
