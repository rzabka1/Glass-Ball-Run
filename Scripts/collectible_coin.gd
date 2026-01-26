extends Collectible
class_name Coin

@onready var coin_collect_sfx: AudioStreamPlayer = $CoinCollectSFX

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if collect(self):
			coin_collect_sfx.play()
