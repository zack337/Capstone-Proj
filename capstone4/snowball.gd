extends Area2D
signal hit_mob

var damage: float = 1
var direction = Vector2()
const SPEED = 700

func _physics_process(delta):
	translate(direction * SPEED * delta)

func _ready() -> void:
	body_entered.connect(on_hit_mob)
	body_entered.connect(on_body_entered)
	
func on_hit_mob(body: Node2D):
	hit_mob.emit()

func on_body_entered(body: Node2D):
	print(body.name)
	if body is RigidBody2D:
		var mob: RigidBody2D = body as RigidBody2D
		mob.apply_damage(damage)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hit_mob() -> void:
	pass # Replace with function body.
