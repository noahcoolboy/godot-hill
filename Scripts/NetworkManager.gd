extends Node

signal connected
signal packet

class_name NetworkManager

export (NodePath) var handler

var Handler = load("res://Scripts/PacketHandler.gd").new()
var Socket = StreamPeerTCP.new()
var connected = false

func _ready():
	add_child(Handler)

func readUIntv(buffer: PoolByteArray):
    var ret = {}
    if (buffer[0] & 1):
        ret.end = 1
        ret.data = buffer[0] >> 1
    elif(buffer[0] & 2):
        ret.end = 2
        ret.data = ((buffer[0])+(buffer[0]*256) >> 2) + 0x80
    elif(buffer[0] & 4):
        ret.end = 3
        ret.data = (buffer[2] << 13) + (buffer[1] << 5) + (buffer[0] >> 3) + 0x4080
    else:
        ret.end = 4
        ret.data = (((buffer[0])+(buffer[1]*256)+(buffer[2]*65536)+(buffer[3]*16777216)) / 8) + 0x204080
    return ret

func ConnectToHost(ip,port):
	Socket.connect_to_host(ip,port)
	connected = true
	emit_signal("connected")
	print("Connected")
func StringToPacket(type : int, string: String):
	return PoolByteArray((char(type)+string).to_ascii())

func SendPacket(packet):
	Socket.put_data((PoolByteArray([1]) + packet))

func checkPacket():
	if not connected: 
		return null
	var packet = Socket.get_available_bytes()
	if(packet > 4):
		
		var uintv = Socket.get_data(4)[1]
		var uintvinfo = readUIntv(uintv)
		var packetrest = Socket.get_partial_data(uintvinfo.data-4+uintvinfo.end)[1]
		uintv.append_array(packetrest)
		emit_signal("packet",uintvinfo,packetrest)
		Handler.onpacket(uintvinfo,uintv)

