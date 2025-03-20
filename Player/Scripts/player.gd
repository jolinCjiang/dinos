class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var move_speed : float = 100.0
var state : String = "idle"

@onready var animation_player : AnimationPlayer = $AnimationPlayer2
@onready var sprite : Sprite2D = $Sprite2D2

 # called when node enters scene tree for the first time
func _ready():
	pass

	
	# called every frame (delta is time elapsed since last frame)
func _process(delta):
		
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	if Input.get_action_strength("Down") != 0:
		print("down!")
	
	velocity = direction * move_speed

	UpdateAnimation()
	
	pass
	
	
func _physics_process(delta):
	move_and_slide()
	

func SetDirection() -> bool:
	
	return true
	
func SetState() -> bool:
	
	return true
	
func UpdateAnimation() -> void:
	animation_player.play("idle_down")
	pass
