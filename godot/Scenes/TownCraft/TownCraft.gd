extends Spatial

var craft_map = []
var craft_map_dimension := 10
var length := 1

# 1= empty , 2 = base , 3 = logs , 4 = roof
enum Parts {
	zero,emp, base , logs , roof
}

var parts = Parts.emp

func _init():
	init_craft_map()

func _ready():
	$house_roof_init.translation = Vector3(int($house_roof_init.translation.x), int($house_roof_init.translation.y) , int($house_roof_init.translation.z))
	$house_roof_init.positionInArray = Vector3(craft_map_dimension /2 , 0 , craft_map_dimension/2)
	pass

func WaveFunctionCollapse():
	pass

# 1=right,2 = left , 3 = front , 4 = back , 5 = up , 6 = down
func AddPart( clicked_node, direction_enum , dir : Vector3 ):
	var assignedPos : Vector3 = clicked_node.positionInArray + dir
	
	var assignedPart = 2
	# check bounday condition
	if (assignedPos.x < 0 or assignedPos.y < 0 or assignedPos.z < 0 or
	assignedPos.x >= craft_map_dimension or assignedPos.y >= craft_map_dimension or assignedPos.z >= craft_map_dimension
		):
		return
		pass
	
	var right = assignedPos + Vector3(1,0,0)
	var left = assignedPos + Vector3(-1,0,0)
	var front = assignedPos + Vector3(0,0,1)
	var back = assignedPos + Vector3(0,0,-1)
	var up = assignedPos + Vector3(0,1,0)
	var down = assignedPos + Vector3(0,-1,0)
	
	if (craft_map[up.x][up.y][up.z] == -1): # nothing above
		assignedPart = 4 # roof
		if (craft_map[down.x][down.y][down.z] == -1): # if also nothing below then wave function collapse
			WaveFunctionCollapse()
			pass
		pass
		
	pass

func init_craft_map():
	craft_map = []
	craft_map.resize(craft_map_dimension)
	for i in range(craft_map_dimension):
		craft_map[i] = []
		craft_map[i].resize(craft_map_dimension)
		for j in range(craft_map_dimension):
			craft_map[i][j] = []
			craft_map[i][j].resize(craft_map_dimension)
			for k in range(craft_map_dimension):
				craft_map[i][j][k] = -1
	pass
