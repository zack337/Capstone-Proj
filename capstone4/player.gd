extends Area2D
signal hit
signal fire_snowball(position: Vector2, direction: Vector2)

@export var speed = 400
var screen_size
var direction = Vector2()
var stick_input = Vector2(0, 0)


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
	#if OS.get_name() != "IOS":
		#if Input.is_action_pressed("move_right"):
			#velocity.x += 1
		#if Input.is_action_pressed("move_left"):
			#velocity.x -= 1
		#if Input.is_action_pressed("move_down"):
			#velocity.y += 1
		#if Input.is_action_pressed("move_up"):
			#velocity.y -= 1
	#else: 
	velocity = stick_input

	if velocity.length() > 0:
		direction = velocity.normalized()
		velocity = direction * speed
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	if Input.is_action_just_pressed("throw"):
		fire_snowball.emit($Marker2D.position + position, direction)

	position += velocity * delta * 0.5
	position = position.clamp(Vector2.ZERO, screen_size)
	
	var angle = atan2(direction.y, direction.x) + PI*0.5
	$AnimatedSprite2D.rotation = angle
	


func _on_canvas_layer_use_move_vector(move_vector):
		stick_input = move_vector
	
