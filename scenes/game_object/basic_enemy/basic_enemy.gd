extends CharacterBody2D

@onready var visuals := $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var mouseEntered:= $MouseHoverCheck
@onready var health_component: HealthComponent = $HealthComponent

enum BasicEnemyNames{
	BOB,
	JOHN, 
	WEEPINGBELL,
	WOLF,
	KING
}

var enemyName: String = "";
var is_stunned: bool = false;

func _ready():
	$HurtboxComponent.hit.connect(on_hit)
	enemyName = BasicEnemyNames.find_key(BasicEnemyNames.values().pick_random())
	mouseEntered.mouse_entered.connect(_on_mouse_enter)
	mouseEntered.mouse_exited.connect(_on_mouse_exit)


func _process(delta):
	if (!is_stunned):
		velocity_component.accelerate_to_player()
		velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)

func get_enemyName():
	return enemyName


func on_hit():
	$HitRandomAudioPlayerComponent.play_random()
	if (!is_stunned):
		is_stunned = true;
		shake();
		await get_tree().create_timer(.4).timeout
		is_stunned = false;
	
func _on_mouse_enter() -> void:
	print("ENTER: ", enemyName)
	EventBus.enemy_hovered.emit(
		self
	)

func _on_mouse_exit() -> void:
	EventBus.enemy_unhovered.emit()
	
func shake():
	var tween = create_tween()

	tween.tween_property(visuals, "position:x", -5.0, 0.05)
	tween.tween_property(visuals, "position:x", 5.0, 0.05)
	tween.tween_property(visuals, "position:x", -5.0, 0.05)
	tween.tween_property(visuals, "position:x", 5.0, 0.05)
	tween.tween_property(visuals, "position:x", 0.0, 0.05)
