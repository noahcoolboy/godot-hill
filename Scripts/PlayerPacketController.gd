extends Node
#PlayerPacketController
var PlayerModel = load("res://Scenes/Player.tscn").instance()
export var cam : NodePath
func newPlayer(Id):
	var TempPlayer = PlayerModel.duplicate()
	get_node("../..").add_child(TempPlayer)
	TempPlayer.name = str(Id)
	TempPlayer.translate(Vector3(0,10,0))
	print(TempPlayer.find_node("CameraPos").get_path())
	get_node(cam).ANCHOR_NODE_PATH = TempPlayer.find_node("CameraPos").get_path()
	_reparent(get_node(cam), TempPlayer.find_node("CameraPos"))
	

func _reparent(node, new_parent):
	node.get_parent().remove_child(node) # error here  
	new_parent.add_child(node)