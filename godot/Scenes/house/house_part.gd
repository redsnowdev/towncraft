extends Spatial

enum Part {
	zero , base , logs , roof
}

export (Part) var part = Part.zero

var townCraft
var positionInArray : Vector3 = Vector3.ZERO

func _ready():
	pass


func _on_AreaRight_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			var nd = $Cube001/ClickArea.get_child(shape_idx)
			print(nd.name)
			var dir_vec = Vector3(nd.translation - translation).normalized()
			print(translation )
			print(dir_vec)
	pass 
