extends StaticBody2D
@export var Starting_health = 70
var health

func _ready():
	health = Starting_health
	
@export var SPAWNING = true
@export var MAX_GOBLINS = 5

var GOBLIN_SCENE = preload("res://enemies/Goblin.tscn")


func get_random_pos_in_sphere (radius : float) -> Vector2:
	var x1 = randf_range (-1, 1)
	var x2 = randf_range (-1, 1)

	while x1*x1 + x2*x2 >= 1:
		x1 = randf_range (-1, 1)
		x2 = randf_range (-1, 1)

	var random_pos_on_unit_sphere = Vector2 (
		2 * x1 * sqrt (1 - x1*x1 - x2*x2),
		2 * x2 * sqrt (1 - x1*x1 - x2*x2))

	return random_pos_on_unit_sphere * randf_range (0, radius)

func _on_Timer_timeout():
	if(SPAWNING):
		if(get_tree().get_nodes_in_group("Goblin").size() <= MAX_GOBLINS ):
			var spawnPoint = position + get_random_pos_in_sphere(50)
			var goblin = GOBLIN_SCENE.instantiate()
			goblin.position = spawnPoint
			get_parent().add_child(goblin)

func hit():
	pass
