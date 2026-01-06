extends CanvasLayer

@onready var platform_bg_texture: Sprite2D = $"../PlatformBgTexture"
@onready var platform_bg_color: ColorRect = $"../PlatformBgColor"


func _on_bg_check_button_toggled(toggled_on: bool) -> void:
	match toggled_on:
		true:
			platform_bg_texture.visible = true
			platform_bg_color.visible = false
		false:
			platform_bg_texture.visible = false
			platform_bg_color.visible = true
	
