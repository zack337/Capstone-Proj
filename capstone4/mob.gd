extends RigidBody2D

var health: float = 1.0
var Damage: float = 1.0

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func apply_damage(damage: float):
	health = clamp(health - damage, 0.0, 100.0)
	if health == 0:
		queue_free()
	print(health)
