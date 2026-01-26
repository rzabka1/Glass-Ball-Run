extends Collectible
class_name Flag


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect("flag")
