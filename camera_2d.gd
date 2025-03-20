class_name DynamicCamera2D extends Camera2D

@export var player : Node2D

func _physics_process(delta):
	var calculated_position : Vector2 = player.global_position
	var offset_calc = (get_global_mouse_position() - calculated_position) / 2
	offset_calc = Vector2(clamp(offset_calc.x, -50, 50), clamp(offset_calc.y, -50, 50))
	calculated_position += offset_calc
	self.position = self.position.lerp(calculated_position, delta * (calculated_position - self.position).length())
