extends Area2D
signal hit
signal fire_snowball(position: Vector2, direction: Vector2)

@export var speed = 400
var screen_size
var direction = Vector2()


func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = position
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		direction = velocity.normalized()
		velocity = direction * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	if Input.is_action_just_pressed("throw"):
		fire_snowball.emit($Marker2D.position + position, direction)

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
