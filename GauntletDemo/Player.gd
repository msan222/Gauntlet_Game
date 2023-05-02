extends CharacterBody2D

var BATTLEAXE_SCENE = preload("res://Weapons/battleAxe.tscn")

const SPEED = 75

var movedir = Vector2()
var can_fire = true
var fire_rate = 4
var facingDir = "RIGHT"
var health = 100

func _ready():
	set_process(true)

func _physics_process(delta):
	if(get_tree().get_nodes_in_group("Weapon").size() >= 1):
		can_fire = false
	elif(get_tree().get_nodes_in_group("Weapon").size() == 0):
		can_fire = true
	controls_loop()
	movement_loop()


func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var FIRE = Input.is_action_just_pressed("ui_j")
	
	if(LEFT):
		$Sprite2D.play("run")
		$Sprite2D.flip_h = true
		facingDir = "LEFT"
	elif(RIGHT):
		$Sprite2D.play("run")
		$Sprite2D.flip_h = false
		facingDir = "RIGHT"
	elif(UP):
		$Sprite2D.play("run")
		facingDir = "UP"
	elif(DOWN):
		$Sprite2D.play("run")
		facingDir = "DOWN"
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	var weaponVector = movedir
	
	if(movedir == Vector2.ZERO):
		$Sprite2D.play("idle")
			
	if(FIRE):
		if(can_fire):
			var battleAxe = BATTLEAXE_SCENE.instantiate()
			battleAxe.position = get_node("Marker2D").get_global_position()
			if(weaponVector == Vector2.ZERO):
				if(facingDir == "RIGHT"):
					weaponVector = Vector2(1, 0)
				elif(facingDir == "LEFT"):
					weaponVector = Vector2(-1, 0)
				elif(facingDir == "UP"):
					weaponVector = Vector2(0, -1)
				elif(facingDir == "DOWN"):
					weaponVector = Vector2(0, 1)
			battleAxe.apply_impulse((weaponVector * battleAxe.BATTLEAXE_SPEED), Vector2.ZERO)
			#battleAxe.set_angular_velocity(20)
			get_parent().add_child(battleAxe)
			can_fire = false
		
func movement_loop():
	var motion = movedir.normalized() * SPEED
	set_velocity(motion)
	set_up_direction(Vector2(0,0))
	move_and_slide()
	


func _on_Area2D_body_entered(body):
	print(body.is_in_group("Enemy"))
	if(body.is_in_group("Enemy")):
		health -= body.damage
		print(health)
