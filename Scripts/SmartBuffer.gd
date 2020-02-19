extends Object
class_name SmartBufferReader
var buffer = PoolByteArray()
var index = 0

func fromPoolByteArray(array: PoolByteArray = PoolByteArray()):
	buffer = array

func fromArray(array: Array = []):
	buffer = PoolByteArray(array)

func readInt8():
	index += 1
	if buffer[index - 1] <= 127: # Positive buffer
		return buffer[index - 1]
	else: # negative
		return buffer[index - 1]-256

func readUInt8():
	index += 1
	return buffer[index - 1]

func readInt16BE():
	if buffer[index] <= 127: #positive
		return readUInt16BE()
	else: #negative
		return readUInt16BE()-pow(2,16)

func readInt16LE():
	if buffer[index] <= 127: #positive
		return readUInt16LE()
	else: #negative
		return readUInt16LE()-pow(2,16)

func readUInt16BE():
	return (self.readUInt8()*256)+(self.readUInt8())

func readUInt16LE():
	return (self.readUInt8())+(self.readUInt8()*256)

func readInt32BE():
	if buffer[index] <= 127:
		return readUInt32BE()
	else:
		return readUInt32BE()-pow(2,32)

func readInt32LE():
	if buffer[index] <= 127:
		return readUInt32LE()
	else:
		return readUInt32LE()-pow(2,32)

func readUInt32BE():
	return (self.readUInt8()*16777216)+(self.readUInt8()*65536)+(self.readUInt8()*256)+(self.readUInt8())

func readUInt32LE():
	return (self.readUInt8())+(self.readUInt8()*256)+(self.readUInt8()*65536)+(self.readUInt8()*16777216)

func toOffset(offset: int = 0):
	index = offset

func _init(fromarray: PoolByteArray = PoolByteArray()):
	buffer = fromarray
