extends Node


@export var end_screen_scene: PackedScene

var paused_menu_scene = preload("res://scenes/ui/pause_menu.tscn")
@onready var EnemyBarUI := $EnemyBarUI/Control/VBoxContainer
var current_displayed_enemy


func _ready():
	EventBus.enemy_hovered.connect(onEnemyHovered);
	EventBus.enemy_unhovered.connect(onEnemyUnHovered);
	%Player.health_component.died.connect(on_player_died)

func _process(delta):
	if current_displayed_enemy != null:
		EnemyBarUI.get_node("ProgressBar").value = current_displayed_enemy.health_component.get_health_percent()
	if current_displayed_enemy == null:
		EnemyBarUI.visible = false
		

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		add_child(paused_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()


func on_player_died():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	MetaProgression.save()
	
func onEnemyHovered(enemy):
	EnemyBarUI.visible = true
	current_displayed_enemy = enemy;
	EnemyBarUI.get_node("MarginContainer/Label").text = current_displayed_enemy.get_enemyName();
	EnemyBarUI.get_node("ProgressBar").value = current_displayed_enemy.health_component.get_health_percent();
	
func onEnemyUnHovered():
	if (current_displayed_enemy != null):
		current_displayed_enemy = null
	EnemyBarUI.visible = false
