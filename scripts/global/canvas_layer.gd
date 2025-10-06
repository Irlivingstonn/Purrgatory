extends CanvasLayer

@onready var portrait: Sprite2D = $Chara

func _ready():

	offset = Vector2.ZERO                  # don't shift the layer off-screen
	var screen_size: Vector2 = Vector2(get_viewport().get_visible_rect().size)
	portrait.visible = true
	portrait.modulate = Color(1,1,1,1)
	portrait.position = screen_size * Vector2(0.12, 0.5)  # or screen_size / 2.0 to center
