extends RigidBody2D

var angle

func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("Left", "Right")
	if direction:
		var speed = 500
		if angle != null and angle < 75 and angle > -75:
			if direction < 0:
				speed += angle * 30
			elif direction > 0:
				speed -= angle * 30
		else:
			speed = speed / 2
		apply_central_force(Vector2(direction*speed,0))
	if Input.is_action_just_pressed("Jump") and angle != null and angle < 75 and angle > -75:
			apply_central_force(Vector2(0,-40000))
	$RayCast2D.rotation = -rotation + 89.54


func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	var _contacted = get_colliding_bodies()
	if _contacted.size() > 0:
		if _state.get_contact_count() > 1:
			var closest_to_zero:float = 361
			for i in _state.get_contact_count():
				var pos = _state.get_contact_collider_position(i)
				var one_of_angles = rad_to_deg($RayCast2D.get_angle_to(pos))
				if 0-abs(closest_to_zero) < 0-abs(one_of_angles):
					closest_to_zero = one_of_angles
			angle = closest_to_zero
		else:
			var pos = _state.get_contact_collider_position(0)
			angle = rad_to_deg($RayCast2D.get_angle_to(pos))
	else:
		angle = null
