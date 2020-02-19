extends Node
var SupperBuffer = load("res://Scripts/SuperBuffer.gd")
var BRKParser = load("res://Scripts/BRKParser.gd").new()
class_name PacketHandler
export (NodePath) var Cube

func _ready():
	add_child(BRKParser)

func onpacket(uintvinfo, packet):
	print("Packet recieved")
	packet = packet.subarray(uintvinfo.end,packet.size()-1) # Remove uintv
	
	packet = Decompress(packet)
	var packetBuffer = SuperBuffer.new()
	packetBuffer.set_big_endian(false)
	packetBuffer.set_data_array(packet)
	var type = packetBuffer.get_u8()
	print("Type is "+str(type))
	if type == 1:
#		Global.NetId = packetBuffer.get_u32()
#		Global.BrickCount = packetBuffer.get_u32()
#		Global.UserId = packetBuffer.get_u32()
#		Global.Username = packetBuffer.get_stringNT()
#		Global.Admin = packetBuffer.get_bool()
#		Global.MembershipType = packetBuffer.get_u8()
		
		get_node("../../../PPC").newPlayer(packetBuffer.get_u32())
	elif type == 2:
		var damap = ""
		var temp = packetBuffer.get_stringNT()
		while temp != "":
			damap = damap + temp
			temp = packetBuffer.get_stringNT()
		
		var map = BRKParser.parse(damap, true)
	elif type == 6:
		pass
		

func Decompress(packet):
	return packet.decompress(2147483647,1)