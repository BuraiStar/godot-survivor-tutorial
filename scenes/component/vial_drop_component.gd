extends Node
class_name VialDropComponent

@export_range(0, 1) var drop_rate: float = 1
@export var health_component: HealthComponent
@export var gold_drop: PackedScene


func _ready():
	health_component.died.connect(on_died)


func on_died():
	var adjusted_drop_rate = drop_rate
	var experience_gain_upgrade_count = MetaProgression.get_upgrade_count("experience_gain")
	if experience_gain_upgrade_count > 0:
		adjusted_drop_rate += experience_gain_upgrade_count * 0.1
	
	if randf() > adjusted_drop_rate:
		return
	
	if gold_drop == null:
		return
	
	if not owner is Node2D:
		return

	var spawn_position = (owner as Node2D).global_position
	var gold_instance = gold_drop.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(gold_instance)
	gold_instance.global_position = spawn_position
