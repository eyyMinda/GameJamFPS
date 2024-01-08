extends Label


func Notify(Duration, Text):
	self.text = str(Text)
	await get_tree().create_timer(Duration).timeout
	self.text = ""
