extends Node2D
class_name LightningArrowAbility

@onready var hitbox_component: HitboxComponent = $HitboxComponent
var hit := false
var arrowModifiers = {
	"speed": 100,
	"direction": Vector2(0.0,0.0),
	"scale": Vector2(1.0, 1.0)
}

func _ready():
	hitbox_component.hit.connect(on_hit)

func _physics_process(delta):
	global_position += arrowModifiers["direction"] * arrowModifiers["speed"] * delta
	
func on_hit(hit_position: Vector2, target: Node2D):
	print("onHit")
	if hit:
		return

	hit = true
	
	_on_hit_effects(hit_position, target)

	queue_free()
	
func _on_hit_effects(hit_position, target):
	pass
