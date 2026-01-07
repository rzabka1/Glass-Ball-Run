extends CanvasLayer

@onready var platform_bg_texture: Sprite2D = $"../PlatformBgTexture"
@onready var platform_bg_color: ColorRect = $"../PlatformBgColor"


func _on_bg_check_button_toggled(toggled_on: bool) -> void:
	platform_bg_texture.visible = toggled_on
	platform_bg_color.visible = not toggled_on
	
