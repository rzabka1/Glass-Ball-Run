extends Collectible
class_name Flag

@onready var flag_collect_sfx: AudioStreamPlayer = $FlagCollectSFX

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if collect(self):
			flag_collect_sfx.play()
