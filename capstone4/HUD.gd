extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$Message.text = "Space \nShooters"
	$Message.show()
	await  get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(time_score, kill_score):
	$ScoreLabel.text = "Time Score: %s" % str(time_score)
	$Mob_counter.text = "Mob Score: %s" % str(kill_score)
 
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	
func _on_message_timer_timeout():
	$Message.hide()
