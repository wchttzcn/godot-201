extends Node2D

signal restart_requested

var is_ready_to_restart = false

func _ready() -> void:
	$Timer.start(randf_range(3, 7))

func _process(delta):
	if is_ready_to_restart and Input.is_action_just_pressed("restart"):
		restart_requested.emit()

func resolve_duel(action):
	if action == "p1_shoot":
		$Cowboy2.kill()
	elif action == "p2_shoot":
		$Cowboy.kill()

func start_duel():
	$Cowboy.is_allowed_to_shoot = true
	$Cowboy2.is_allowed_to_shoot = true
	$Plank/Label.text = "SHOOT!"
	$Plank/Label.add_theme_color_override("font_color", Color.CHARTREUSE)
	
func game_over():
	$EndMusicPlayer.play()
	$AnimationPlayer.play("restart")
	is_ready_to_restart = true
