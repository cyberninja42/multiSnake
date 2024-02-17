extends Area2D


const SPEED = 0.1
var buff_dir = Vector2(1,0)
var dir = Vector2(1,0)
var gridsize = 40
var parent = null
var old_position = position

func _ready():
	pass
	
func _draw():
	draw_circle(Vector2(0, 0), 20, Color.WHITE)
	
func set_parent(p):
	parent = p

#Move snake segment towards it's parents old position
func _physics_process(delta):
	if parent != null:
		position = position.move_toward(parent.old_position, SPEED*gridsize)
		if (position == round(position/gridsize)*gridsize):
			old_position = round(position/gridsize)*gridsize
	pass
