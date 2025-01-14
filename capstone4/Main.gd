extends Node

@export var snowball: PackedScene
@export var mob_scene: PackedScene
var score
var points = 0

const SNOWBALL = preload("res://snowball.tscn")

func game_over():
	if $Player.fire_snowball.is_connected(spawn_snowball):
		$Player.fire_snowball.disconnect(spawn_snowball)
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$Player.hide()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Player.fire_snowball.connect(spawn_snowball)
	$Player.show()
	$Music.play()
	$My_Name.hide()
	points = 0

func on_point_gained():
	points += 1
	print(points)
	$HUD.update_points(points)

func spawn_snowball(position: Vector2, direction: Vector2):
	var snowball = SNOWBALL.instantiate()
	get_parent().add_child(snowball)
	snowball.position = position
	snowball.direction = direction
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _ready():
	pass
