extends Spatial

var camrot_h = 0
var camrot_v = 0
var v_senstivity = 0.1
var v_acc = 10
var v_min_angle
var v_max_angle

var h_senstivity = 0.1
var h_acc = 10
var smootTime = 0.2

var mousePosition : Vector2 = Vector2.ZERO
var rayIntersectingPoint

var move_direction :Vector3 = Vector3.ZERO
var player

var crafting_mode : bool = false
var mouse_button_right_pressed : bool = false
var mouse_button_middle_pressed : bool = false
var mouse_pos_mid_start : Vector2 = Vector2.ZERO
var init_translation : Vector3 = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player = get_parent()
	pass

func _input(event):
	if event is InputEventMouseMotion:
		if crafting_mode :
			if mouse_button_right_pressed:
				camrot_h +=  -event.relative.x * h_senstivity
				camrot_v += -event.relative.y * v_senstivity
		else :
			camrot_h +=  -event.relative.x * h_senstivity
		pass
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT :
			mouse_button_right_pressed = event.pressed
		if event.button_index == BUTTON_MIDDLE :
			mouse_button_middle_pressed = event.pressed
			if event.pressed:
				mouse_pos_mid_start = event.position
				init_translation = translation
	pass

func _process(delta):
	mousePosition = get_viewport().get_mouse_position()
	if crafting_mode:
		CraftingMode(delta)
	else :
		PlayMode(delta)
	pass

func PlayMode (delta):
	$h.rotation_degrees.y = lerp($h.rotation_degrees.y , camrot_h ,delta *  h_acc ) 
	$h/v.rotation_degrees.x = lerp($h/v.rotation_degrees.x , camrot_v , delta *  v_acc )
	
func CraftingMode (delta):
	if mouse_button_middle_pressed :
		var translation_vector = Vector3(init_translation.x + (mouse_pos_mid_start.x - mousePosition.x)*0.1 , translation.y
		, init_translation.y +  (mouse_pos_mid_start.y - mousePosition.y)*0.1)
		translation = translation_vector.rotated(Vector3.UP , 0)
		pass
	elif mouse_button_right_pressed:
		$h.rotation_degrees.y = lerp($h.rotation_degrees.y , camrot_h ,delta *  h_acc ) 
		$h/v.rotation_degrees.x = lerp($h/v.rotation_degrees.x , camrot_v , delta *  v_acc ) 
	pass

func RaycastToWorld():

	if !mousePosition:
		return
	var worldSpace = get_world().direct_space_state
	var start = $h/v/Camera.project_ray_origin(mousePosition)
	var end = $h/v/Camera.project_position(mousePosition , 10000)
	var result = worldSpace.intersect_ray(start , end)
	if result:
		$'../ray_pointer'.transform.origin = to_global( result.position )
	pass

func CraftingModeStatus(status):
	crafting_mode = status
	if status == false:
		camrot_v = 0
		translation = Vector3.ZERO
	pass
