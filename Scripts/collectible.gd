@abstract
class_name Collectible
extends Area2D

var id:int = -100

func collect(collectible_type:Collectible) -> bool:
	if collectible_type is Coin:
		Global.collected_coins_count += 1
	elif collectible_type is Flag:
		print("flag id: ", id, " Last checkpoint id: ", Global.last_checkpoint.id, " Last flag id: ", Global.last_flag_id)
		# Checking if collected flag is NEXT checkpoint's flag to avoid skipping levels
		if id == Global.last_checkpoint.id + 1 and id == Global.last_flag_id + 1:
			Global.last_flag_id = id
		else:
			return false
	Global.collected_before_checkpoint.append(self)
	enable_disable(false)
	return true

func uncollect(collectible_type:Collectible) -> void:
	if collectible_type is Coin:
		Global.collected_coins_count -= 1
	elif collectible_type is Flag:
		Global.last_flag_id -= 1
	enable_disable(true)

func enable_disable(is_enabling:bool) -> void: # enabling if true, disabling if false
	for child in get_children():
		if child is Sprite2D:
			child.visible = is_enabling
	set_deferred("monitoring", is_enabling)
