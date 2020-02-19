extends Node
class_name BRKParser

func parse(string : String, loadit: bool):
	var line = null
	var bricks = []
	var args = []
	var lines = string.split("\n")
	for index in len(lines):
		line = lines[index]
		if index > 7:
			if not line.begins_with("	"):
				args = line.split(" ")
				var nums = []
				for arg in args:
					nums.append(float(arg))
				if len(args) == 1: 
					continue
				#print(args)
				bricks.append({color = Color(args[6],args[7],args[8], args[9]), visibility = args[9], size = Vector3(nums[3]/2,nums[5]/2,nums[4]/2), pos = Vector3(nums[3]/2+nums[0],nums[5]/2+nums[2],nums[4]/2+nums[1])})
			else:
				pass
				
	#print(bricks)	
	if loadit:
		loadmap(bricks)
	return bricks
		
func loadmap(map):
	return
	for brickProps in map:
		var brick = get_node("/root/Node/Spatial/Cube")
		brick = brick.duplicate()
		get_node("../..").add_child(brick)
		brick.visible = true
		brick.translation = Vector3(0,0,0)
		brick.translate(brickProps.pos)
		brick.scale = brickProps.size
		var mat = brick.get_node("MeshInstance").material_override.duplicate()
		mat.albedo_color = brickProps.color
		#if brickProps.color.a != 255:
		#	mat.flags_transparent=true
		brick.get_node("MeshInstance").material_override = mat
		brick.name = str(brickProps.pos)