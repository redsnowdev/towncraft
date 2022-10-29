extends Spatial

enum Part {
	zero ,empty ,base , logs , roof
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
			var dir_vec = Vector3(nd.global_translation - global_translation).normalized()
			var spawn_pos : Vector3 = translation + dir_vec *2
			print(str(translation) + ' ' + str(dir_vec) + ' ' + str(nd.translation))
			get_parent().AddPart(self , shape_idx , dir_vec , spawn_pos)
	pass 
