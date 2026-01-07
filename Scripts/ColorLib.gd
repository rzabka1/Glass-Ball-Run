extends Node

# These are actually *flag* colors
var level_colors:Array[Color] = [
	Color(0.743, 0.463, 0.778, 1.0),
	Color(0.99, 0.538, 0.663, 1.0),
	Color(1.0, 0.33, 0.531, 1.0),
	Color(0.89, 0.356, 0.356, 1.0),
	Color(0.933, 0.44, 0.342, 1.0),
	Color(0.63, 0.36, 0.214, 1.0),
	Color(0.75, 0.529, 0.36, 1.0),
	Color(0.87, 0.756, 0.444, 1.0),
	Color(0.643, 0.75, 0.292, 1.0),
	Color(0.557, 0.713, 0.406, 1.0),
	Color(0.384, 0.65, 0.45, 1.0),
	Color(0.099, 0.45, 0.351, 1.0),
	Color(0.239, 0.515, 0.57, 1.0),
	Color(0.338, 0.714, 0.72, 1.0),
	Color(0.544, 0.638, 0.8, 1.0)
	]
var current_color_index:int = -1
var bg_lightened_value:float = 0.3 # How much lighter background will be than the flag

func pick_level_color() -> Color:
	# Safety check: If array is empty, return a default fallback
	if level_colors.is_empty():
		push_warning("Missing resource: level_colors array is empty")
		return Color.BLACK
	
	var potential_indexes: Array[int] = []
	
	for i in level_colors.size():
		# If current_color_index is -1 (first run), accept everything
		if current_color_index != -1:
			var distance = abs(i - current_color_index)
			
			# Exclude current (0) and immediate neighbours (1)
			if distance <= 1:
				continue # continue = ignore all further instructions and go to the next iteration :>
			
			# WRAPPING LOGIC (Circular Array)
			# e.g., if array size is 15, index 0 and index 14 are neighbours.
			if distance == level_colors.size() - 1:
				continue
		
		potential_indexes.append(i)
	
	# If potential color array is empty, pick the current color again
	if potential_indexes.is_empty():
		potential_indexes.append(current_color_index)
	
	var new_index: int = potential_indexes.pick_random()
	current_color_index = new_index
	
	return level_colors[new_index]
