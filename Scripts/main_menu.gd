extends CanvasLayer

@export var gameplay_viewport:SubViewport
@export var menu_contents:Control
@export var settings:Control
@export var level_selection:Control
@export var checker_bg:Parallax2D

var level_1_scene = preload("res://Scenes/Levels/level_1.tscn")

func _ready() -> void:
	menu_contents.show()
	settings.hide()
	level_selection.hide()

#region Main menu buttons
# PLAY BUTTON
func _on_button_play_pressed() -> void:
	gameplay_viewport.add_child(level_1_scene.instantiate())
	hide()
	checker_bg.scrolling_enabled = false

# SETTINGS
func _on_button_settings_pressed() -> void:
	settings.show()
	menu_contents.hide()

func _on_button_settings_return_pressed() -> void:
	menu_contents.show()
	settings.hide()

# LEVEL SELECTION
func _on_button_levels_pressed() -> void:
	level_selection.show()
	menu_contents.hide()
	
func _on_button_levels_return_pressed() -> void:
	menu_contents.show()
	level_selection.hide()

#endregion

func _on_button_back_to_menu_pressed() -> void:
	checker_bg.scrolling_enabled = true
	show()
	# Handle level removal
	gameplay_viewport.remove_child(gameplay_viewport.get_child(0))
	Global.reset_variables()
	
