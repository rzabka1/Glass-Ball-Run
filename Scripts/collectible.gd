class_name Collectible
extends Area2D

enum type {COIN = 0, FLAG = 1}

var id:int = NAN
var audio_stream_player:AudioStreamPlayer
@export var collectible_type:type = type.COIN
@onready var tileset_texture:CompressedTexture2D = preload("res://Assets/Sprites/black_white_sheet.png")

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	create_sprite(match_sprite_regions_and_sfx_to_type()[0])
	create_audio_player(match_sprite_regions_and_sfx_to_type()[1])
	create_collision()

func match_sprite_regions_and_sfx_to_type() -> Array:
	var region:Vector2
	var sfx:AudioStreamWAV
	match collectible_type:
		0: # COIN
			region = Vector2(0,64)
			sfx = load("res://Assets/Audio/redball-sfx-flag.wav") # Temporarily the same as flag
		1: # FLAG
			region = Vector2(96,32)
			sfx = load("res://Assets/Audio/redball-sfx-flag.wav")
		_:
			printerr("collectible.gd: Invalid collectible type!")
			breakpoint
	var reg_sfx_arr:Array = [region, sfx]
	return reg_sfx_arr

func create_sprite(reg:Vector2) -> void:
	var sprite:Sprite2D = Sprite2D.new()
	set_up_sprite(sprite, Rect2(reg.x, reg.y, 32, 32))
	add_child(sprite)

func set_up_sprite(sprite, rect) -> void:
	sprite.texture = tileset_texture
	sprite.scale = Vector2(2.0, 2.0)
	sprite.region_enabled = true
	sprite.region_rect = rect

func create_collision() -> void:
	var collision_area:CollisionShape2D = CollisionShape2D.new()
	collision_area.shape = load("res://Resources/collectible_collision.tres")
	add_child(collision_area)

func create_audio_player(sfx):
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = sfx
	add_child(audio_stream_player)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect()

func collect() -> void:
	if collectible_type == 0:
		Global.collected_coins_count += 1
	elif collectible_type == 1:
		print("flag id: ", id, " Last checkpoint id: ", Global.last_checkpoint.id, " Last flag id: ", Global.last_flag_id)
		# Checking if collected flag is NEXT checkpoint's flag to avoid skipping levels
		if id == Global.last_checkpoint.id + 1 and id == Global.last_flag_id + 1:
			Global.last_flag_id = id
		else:
			return
	Global.collected_before_checkpoint.append(self)
	audio_stream_player.play()
	enable_disable(false)

func uncollect() -> void:
	if collectible_type == 0:
		Global.collected_coins_count -= 1
	elif collectible_type == 1:
		Global.last_flag_id -= 1
	enable_disable(true)

func enable_disable(is_enabling:bool) -> void: # enabling if true, disabling if false
	for child in get_children():
		if child is Sprite2D:
			child.visible = is_enabling
	set_deferred("monitoring", is_enabling)
