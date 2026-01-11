extends Node2D

@onready var arm:AnimatableBody2D = $Arm

func _physics_process(delta: float) -> void:
	arm.rotation_degrees += 50 * delta
