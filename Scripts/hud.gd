extends CanvasLayer

@export var coins_count_label:Label
@export var platform_bg_texture:TextureRect
@export var platform_bg_color:ColorRect

func _ready() -> void:
	Global.coins_count_changed.connect(_on_coins_count_changed)
	
	# Initialise the label immediately so it doesn't show default text before the first coin is collected.
	_on_coins_count_changed(Global.collected_coins_count, Global.max_coins)

func _on_coins_count_changed(collected_count: int, total_count: int) -> void:
	if coins_count_label: # Check if assigned, just in case.
		coins_count_label.text = str(collected_count) + " / " + str(total_count)
	else:
		printerr("HUD: assign a Label node for exported variable coins_count_label!")

func _on_bg_check_button_toggled(toggled_on: bool) -> void:
	platform_bg_texture.visible = toggled_on
	platform_bg_color.visible = not toggled_on
