extends Node2D
class_name EarthQuakeAbility

@onready var hitbox_component: HitboxComponent = $HitboxComponent

func _ready() -> void:
	_activate_hurt_box();
	$KillTimer.timeout.connect(queue_free)
	
func _activate_hurt_box():
	$Sprite2D.visible = true
	$HitboxComponent/CollisionShape2D.disabled = false;
	await get_tree().create_timer(0.1).timeout;
	$Sprite2D.visible = false
	$HitboxComponent/CollisionShape2D.disabled = true;
