extends Parallax2D

var scrolling_enabled:bool = true

func _process(delta: float) -> void:
	if scrolling_enabled:
		position.x -= 50 * delta
		position.y -= 50 * delta
	else:
		position = Vector2.ZERO
