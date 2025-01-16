extends CanvasLayer

signal use_move_vector
var move_vector = Vector2(0, 0)
var joystick_active = false
@onready var maxLength = $Big_circle.shape.radius

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $Big_circle.is_pressed():
			move_vector = calculate_move_vector(event.position)
			joystick_active = true
			$InnerCircle.position = event.position
			$InnerCircle.show()
		else:
			joystick_active = false

	if event is InputEventScreenTouch:
		if event.pressed == false:
			$InnerCircle.hide()

func _physics_process(_delta):
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
	else:
		emit_signal("use_move_vector", Vector2(0, 0))

func calculate_move_vector(event_position):
	var texture_center = $Big_circle.position + Vector2(64, 64)
	return (event_position - texture_center).normalized()
