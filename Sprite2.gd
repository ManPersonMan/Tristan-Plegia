extends Sprite

var Mouse_Pos

func _process(delta):
	Mouse_Pos = get_local_mouse_position()
	rotation += Mouse_Pos.angle() * 0.1