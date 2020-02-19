extends Node

func _ready():
	pass
func writeUIntv(buffer : PoolByteArray):
	var length = len(buffer)
	print(length)
	var size = PoolByteArray()
	
	if length < 0x80:
		size.append((length << 1) +1)
		size.append_array(buffer)
		return size
	
	elif length < 0x4080:
		length = (length - 0x80) << 2
		size.append(length)
		return ""