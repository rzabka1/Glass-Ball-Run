extends Node

signal coins_count_changed(collected_count: int, total_count: int)

var max_coins:int = 0
var collected_before_checkpoint = []
var collected_coins_count:int:
	set(new_val):
		if new_val != collected_coins_count:
			collected_coins_count = new_val
			coins_count_changed.emit(collected_coins_count, max_coins)

var all_coins:Array = []
var last_checkpoint:Checkpoint
var last_flag_id:int = -1

func set_max_coins() -> void:
	for coin in all_coins:
		max_coins += 1
		# Emiting the signal here, to ensure the UI updates immediately after calculating the max.
		coins_count_changed.emit(collected_coins_count, max_coins)

func reset_variables():
	max_coins = 0
	collected_before_checkpoint = []
	collected_coins_count = 0
	all_coins = []
	last_checkpoint = null
	last_flag_id = -1
