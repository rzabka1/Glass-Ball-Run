extends Collectible
class_name Coin


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect("coin")
