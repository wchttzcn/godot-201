extends Node2D

enum State {Waiting, Shooting, Dying, Fumbling}

signal shot_gun(action)
signal game_over

@export var action_name = "p1_shoot"

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var press_key: Sprite2D = $PressKey

var current_state = State.Waiting
var is_allowed_to_shoot = false

func _process(_dt) -> void:
	if current_state == State.Waiting and Input.is_action_pressed(action_name):
		if is_allowed_to_shoot:
			shoot()
		else:
			fumble()

func fumble() -> void:
	current_state = State.Fumbling
	anim.play("fumble")

func shoot() -> void:
	current_state = State.Shooting
	anim.play("shoot")
	$AudioStreamPlayer2D.play()
	press_key.visible = false
	shot_gun.emit(action_name)

func kill() -> void:
	current_state = State.Dying
	anim.play("death")
	press_key.visible = false

func waiting() -> void:
	current_state = State.Waiting
	anim.play("idle")

func holster() -> void:
	anim.play("holster")
	game_over.emit()
	$WinLabel.visible = true
