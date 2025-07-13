@tool
extends Sprite2D

@export var square_color: Color = Color.RED:
	set(value):
		square_color = value
		_update_texture()

func _ready():
	_update_texture()

func _update_texture():
	if not is_inside_tree():
		return  # Prevents issues during editor loading

	var img = Image.create(100, 100, false, Image.FORMAT_RGBA8)
	img.fill(square_color)

	var tex = ImageTexture.create_from_image(img)
	self.texture = tex
