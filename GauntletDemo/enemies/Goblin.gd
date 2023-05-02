extends CharacterBody2D

var health = 20
var movedir = Vector2()
@export var GOBLIN_SPEED = 30

var damage = 7

func _ready():
	set_process(true)
	
func _physics_process(_delta):
	movedir = move_toward_player()
	set_velocity(movedir * GOBLIN_SPEED)
	move_and_slide()
	movedir = velocity
	if(movedir.x > 0):
		if($AnimatedSprite2D.flip_h):
			$AnimatedSprite2D.flip_h = false
	elif(movedir.x < 0):
		$AnimatedSprite2D.flip_h = true

func move_toward_player():
	var player = get_tree().get_root().get_node("LevelOne/Player")
	return ( (player.get_global_position() - position).normalized())

func hit():
	$AnimatedSprite2D.play("hit")
	#var tree = get_tree()
	#var root = tree.get_root()
	#var player = root.get_node("Player")
	#print(player)

