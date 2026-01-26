class_name Level
extends Node2D

var player:RigidBody2D
var checkpoint_start:Checkpoint
var all_coins:Array = []
var all_flags:Array = []
@onready var player_respawn_timer:Timer = $PlayerRespawnTimer
@onready var cam:Camera2D = $Camera2D
@onready var player_scene:PackedScene = preload("res://Scenes/rigid_player.tscn")
@onready var collectibles_parent:Node2D = $Collectibles
@onready var checkpoint_parent: Node2D = $Checkpoints
@onready var bg_color: ColorRect = $Bckgr/BgColor
@onready var player_death_sfx: AudioStreamPlayer = $PlayerDeathSfx

func _ready() -> void:
	sort_collectibles()
	Global.all_coins = all_coins
	Global.set_max_coins()
	checkpoint_start = checkpoint_parent.get_node("CheckpointStart")
	assign_checkpoint_id()
	assign_collectible_id()
	set_level_color()

func assign_checkpoint_id():
	var checkpoint_arr:Array = get_all_checkpoints()
	checkpoint_start.id = -1
	for checkp in checkpoint_arr:
		checkp.id = checkpoint_arr.find(checkp)
		print("Chp ID: ", checkp.id)

func assign_collectible_id():
	for flag in all_flags:
		flag.id = all_flags.find(flag)
		print("Flag ID: ", flag.id)
	manage_flag_visibility()

func manage_flag_visibility():
	for flag in all_flags:
		print(flag)
		print("manage - flag id: ", flag.id)
		print("manage - last chp id: ", Global.last_checkpoint.id)
		if flag.id == Global.last_checkpoint.id + 1:
			flag.enable_disable(true)
		else:
			flag.enable_disable(false)

func get_all_checkpoints() -> Array:
	var all_checkpoints:Array = checkpoint_parent.get_children()
	introduce_yourself_to_checkpoints(all_checkpoints)
	all_checkpoints.erase(checkpoint_start)
	return all_checkpoints

func sort_collectibles() -> void:
	for collectible in collectibles_parent.get_children():
		if collectible is Coin:
			all_coins.append(collectible)
		elif collectible is Flag:
			all_flags.append(collectible)

func set_level_color():
	if get_all_checkpoints().size() == all_flags.size():
		for i in get_all_checkpoints().size():
			var flag_color = ColorLib.pick_level_color()
			get_all_checkpoints()[i].modulate = flag_color
			all_flags[i].modulate = flag_color

func introduce_yourself_to_checkpoints(all_checkpoints_including_start:Array):
	for checkpoint in all_checkpoints_including_start:
		checkpoint.level = self

func _process(_delta: float) -> void:
	glue_camera_to_player()

func glue_camera_to_player() -> void:
	if player != null and cam != null:
		cam.position = player.position

func start_respawn_timer() -> void:
	player_respawn_timer.start()

func _on_player_respawn_timer_timeout() -> void:
	add_new_player_instance()
	uncollect_collectibles()

func add_new_player_instance() -> void:
	var new_player:RigidBody2D = player_scene.instantiate()
	add_child(new_player)
	new_player.position = Global.last_checkpoint.position
	player = new_player

func uncollect_collectibles() -> void:
	for collectible in collectibles_parent.get_children():
		if Global.collected_before_checkpoint.has(collectible):
			collectible.uncollect(collectible)
	Global.collected_before_checkpoint.clear()

func _on_world_boundary_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
