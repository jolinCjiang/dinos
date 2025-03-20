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
	
	velocity = direction * move_speed
	
	var state_change : bool = SetState()
	var direction_change : bool = SetDirection()
	if state_change || direction_change:
		UpdateAnimation()
	
	
func _physics_process(delta):
	move_and_slide()
	
	

func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	var h_dir : Vector2 = Vector2.ZERO
	var v_dir : Vector2 = Vector2.ZERO
	
	if direction.x != 0:
		h_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	if direction.y != 0:
		v_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	new_dir = (h_dir + v_dir).normalized()
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	
	return true
	
func SetState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
func UpdateAnimation() -> void:
	var anim_direction : String = AnimDirection()
	if anim_direction != "":
		animation_player.play(state + "_" + AnimDirection())
	
	
func AnimDirection() -> String :
	# Diagonal up
	if cardinal_direction[1] < 0:
		if cardinal_direction[0] < 0:
			return "up_left"
		elif cardinal_direction[0] > 0:
			return "up_right"
		else:
			return "up"
	elif cardinal_direction[1] > 0:
		if cardinal_direction[0] < 0:
			return "down_left"
		elif cardinal_direction[0] > 0:
			return "down_right"
		else:
			return "down"
		
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else: #cardinal_direction == Vector2.LEFT:
		return ""
		
	
