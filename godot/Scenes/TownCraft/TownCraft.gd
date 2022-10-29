extends Spatial

export(PackedScene) var sceneHouseBase
export(PackedScene) var sceneHouseLogs
export(PackedScene) var sceneHouseRoof

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
	var init_house_part_position : Vector3 = $house_roof_init.positionInArray
	#assign the instance to its respective position in the craft_map array
	craft_map[init_house_part_position.x][init_house_part_position.y][init_house_part_position.z] = $house_roof_init 
	
	pass

# 1=right,2 = left , 3 = front , 4 = back , 5 = up , 6 = down
func AddPart( clicked_node, direction_enum , dir : Vector3 , spawn_position : Vector3):
	var assignedPosIndex : Vector3 = clicked_node.positionInArray + dir
	# check bounday condition
	if (assignedPosIndex.x < 0 or assignedPosIndex.y < 0 or assignedPosIndex.z < 0 or
	assignedPosIndex.x >= craft_map_dimension or assignedPosIndex.y >= craft_map_dimension or assignedPosIndex.z >= craft_map_dimension
		):
		return
		pass
	var tmpNode = sceneHouseBase.instance()
	add_child(tmpNode)
	tmpNode.translation = spawn_position
	tmpNode.positionInArray = assignedPosIndex

	WaveFunctionCollapse(assignedPosIndex)
	pass

func WaveFunctionCollapse(assignedPosIndex):
	var assignedPart = 1
	
	var right = assignedPosIndex + Vector3(1,0,0)
	var left = assignedPosIndex + Vector3(-1,0,0)
	var front = assignedPosIndex + Vector3(0,0,1)
	var back = assignedPosIndex + Vector3(0,0,-1)
	var up = assignedPosIndex + Vector3(0,1,0)
	var down = assignedPosIndex + Vector3(0,-1,0)
	
	if (craft_map[up.x][up.y][up.z] == -1): # nothing above
		assignedPart = 4 # roof
		if (craft_map[down.x][down.y][down.z] != -1): # if something below then 
			
			pass
		pass
	pass

func SwapBaseToRoof():
	
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
