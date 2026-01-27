extends CanvasLayer

@export var gameplay_viewport:SubViewport
@export var menu_contents:Control
@export var settings:Control
@export var level_selection:Control

var level_1_scene = preload("res://Scenes/Levels/level_1.tscn")

func _ready() -> void:
	menu_contents.show()
	settings.hide()
	level_selection.hide()

#region Button Connections
# PLAY BUTTON
func _on_button_play_pressed() -> void:
	gameplay_viewport.add_child(level_1_scene.instantiate())
	hide()

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
