extends RigidBody2D

@export var BATTLEAXE_SPEED = 400
@export var BATTLEAXE_DAMAGE = 10
var lastPosition

func _ready():
	set_process(true)
	$Sprite2D.scale = (Vector2(.6, .6))
	lastPosition = position
	

func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("Hitable") and !body.is_in_group("Player")):
		queue_free()
		if(body.health <= 0):
			body.queue_free()
		else:
			body.hit()
			body.health -= BATTLEAXE_DAMAGE
