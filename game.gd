extends Node2D

var world = null

func _ready() -> void:
	create_world()
	
func create_world():
	var world_blueprint = load("res://world.tscn")
	world = world_blueprint.instantiate()
	world.restart_requested.connect(restart)
	add_child(world)

func restart():
	world.queue_free()
	create_world()
