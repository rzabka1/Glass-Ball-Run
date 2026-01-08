extends Node

signal coins_count_changed(collected_count: int, total_count: int)

var max_coins:int = 0
var collected_before_checkpoint = []
var collected_coins_count:int:
	set(new_val):
		if new_val != collected_coins_count:
			collected_coins_count = new_val
			coins_count_changed.emit(collected_coins_count, max_coins)

var all_collectibles:Array = []
var last_checkpoint:Checkpoint
var last_flag_id:int = -1

func set_max_coins() -> void:
	for collectible in all_collectibles:
		if collectible.collectible_type == 0:
			max_coins += 1
			# Emiting the signal here, to ensure the UI updates immediately after calculating the max.
			coins_count_changed.emit(collected_coins_count, max_coins)
