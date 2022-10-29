extends KinematicBody

var direction = Vector3.FORWARD
var velocity := Vector3.ZERO
var gravity = 100
var move_speed = 10

var crafting_mode_activate : bool = false
signal CraftingMode(status)
func _ready():
	pass

func _physics_process(delta):
	if !crafting_mode_activate:
		Mechanics(delta)
	pass

func Mechanics (delta):
	var h_rot = $'Camroot/h'.global_transform.basis.get_euler().y
	direction = Vector3( Input.get_action_strength("right") - Input.get_action_strength("left") , 
	 0 
	, Input.get_action_strength("backward") - Input.get_action_strength("forward") ).rotated(Vector3.UP , h_rot).normalized()
	var dir : Vector3 = direction * move_speed
	velocity.y -= gravity* delta
	velocity.y = clamp(velocity.y , -400 , 400)
	if is_on_floor():
		velocity.y = 0
	velocity = Vector3(dir.x , velocity.y , dir.z)
	move_and_slide(velocity , Vector3.UP)
	pass

func _process(delta):
	Crafting()
	pass

func Crafting():
	#RaycastToWorld()
	if Input.is_action_just_pressed("crafting_mode"):
		if crafting_mode_activate:
			crafting_mode_activate = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			emit_signal("CraftingMode",false)
		else :
			crafting_mode_activate = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			emit_signal("CraftingMode",true)
	pass
