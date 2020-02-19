extends Node

var tcp = StreamPeerTCP.new()
var buffer = PoolByteArray()
var SuperBuffer = load("res://Scripts/SuperBuffer.gd")
var BRKParser = load("res://Scripts/BRKParser.gd")
var NetworkManager = load("res://Scripts/NetworkManager.gd").new()
var packetBuffer = null
var a = 0
var b = 0
var c = 0
var d = 0
var Parser = BRKParser.new()
#func newBrick(brickProps):
	



func _ready():
	OS.set_window_position(OS.get_window_size() / 2) # Center the window
	add_child(NetworkManager)
	NetworkManager.ConnectToHost("127.0.0.1",42480)
	NetworkManager.SendPacket("\u0001abc\u00000.3.0.2\u0000".to_ascii())
	
	return
	var file = File.new()
	file.open("res://map.brk", File.READ)
	var content = file.get_as_text()
	file.close()
	#var eek = Parser.parse("B R I C K  W O R K S H O P  V0.2.0.0\n\n0 0 0\n0.14 0.51 0.20 1\n0.53 0.75 0.92\n40\n400\n\n-12 41 34 4 4 4 0.87 0 0.05 1\n	+NAME brick31\n	+SHAPE spawnpoint\n-20 -20 0 40 40 0.30 0.87 0 0.05 1\n	+NAME die\n	+SHAPE plate")
	var eek = Parser.parse(content)
	#for brick in eek:
		#newBrick(brick)
	tcp.connect_to_host("127.0.0.1",42480)
	buffer = PoolByteArray("\u0001\u0001abc\u00000.3.0.2\u0000".to_ascii())
	tcp.put_data(buffer)
func _process(delta):
	NetworkManager.checkPacket()
func packet(packet:PoolByteArray,uintv:Dictionary):
	packet = packet.subarray(uintv.end,packet.size()-1)
	packetBuffer = SuperBuffer.new()
	packetBuffer.set_big_endian(false)
	packetBuffer.set_data_array(packet)
	var type = packetBuffer.get_u8()
	print(type)
	if type == 1:
		print("netId: "+str(packetBuffer.get_u32()))
		print("brickCount: "+str(packetBuffer.get_u32()))
		print("userId: "+str(packetBuffer.get_u32()))
		print("username: "+str(packetBuffer.get_stringNT()))
		print("admin: "+str(packetBuffer.get_bool()))
		print("membershipType: "+str(packetBuffer.get_u8()))
	elif type == 6:
		print("Message: "+str(packetBuffer.get_stringNT()))
	elif type == 4:
		var player = packetBuffer.get_u32()
		var modifications = packetBuffer.get_stringNT()
		for modification in modifications:
			print(modification)
	elif type == 2:
		pass
