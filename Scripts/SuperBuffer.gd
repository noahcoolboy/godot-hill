extends StreamPeerBuffer
class_name SuperBuffer
func get_stringNT():
	var a = PoolByteArray()
	var b = 1
	while b != 0:
		b = self.get_8()
		a.append(b)
	return a.get_string_from_ascii()
func get_bool():
	return true if self.get_u8() == 1 else false
