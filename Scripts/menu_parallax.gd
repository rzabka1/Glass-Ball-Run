extends Parallax2D


func _process(delta: float) -> void:
	position.x -= 50 * delta
	position.y -= 50 * delta
