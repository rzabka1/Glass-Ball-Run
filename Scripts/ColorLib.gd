extends Node

var current_color:Color
var background_colors:Array = [
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

#func _ready() -> void:
	#current_color = background_colors[0]
	#print(pick_level_color())

func pick_level_color() -> Array:
	var bg_color:Color
	var flag_color:Color
	var darken_value:float = 0.3
	var current_id:int = background_colors.find(current_color)
	var potential_colors:Array = []
	print("Current color: ",current_color)
	print("Current ID: ",current_id)
	
	for color in background_colors:
		# Excluding similar colors
		if background_colors.find(color) != current_id or background_colors.find(color) != current_id-1 or background_colors.find(color) != current_id+1:
			potential_colors.append(color)
	bg_color = potential_colors.pick_random()
	flag_color = bg_color.darkened(darken_value)
	
	current_color = bg_color
	var bg_and_flag:Array = [bg_color, flag_color]
	return bg_and_flag
